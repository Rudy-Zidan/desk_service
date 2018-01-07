module LynksServiceDesk
  class TicketsController < ApplicationController
    require 'aasm'
    include LynksServiceDesk::TicketHelper
    using LynksServiceDesk::Refinements

    skip_before_action :verify_authenticity_token
    before_action :set_ticket, only: [:show, :update, :transition_state, :metrics, :objects]

    CONFIG = LynksServiceDesk::Formatters::Config

    def index
      permitted_params = params.permit(:page, :limit, :scope)
      page = permitted_params[:page] || 1
      limit = permitted_params[:limit] || 30
      scope = permitted_params[:scope]

      if scope.present? && LynksServiceDesk::Ticket.respond_to?(scope)
        @tickets = LynksServiceDesk::Ticket.send(scope).page(page).per(limit)
        # although we can chain page and per, it is better this way
        # or else, the tickets will load all of the tickets in the scope which
        # may be a lot
      else
        @tickets = LynksServiceDesk::Ticket.page(page).per(limit)
      end

      respond_to do |format|
        format.json { render json:
          @tickets.map(&:hash_format).to_json
        }
      end
    end

    def new

      @a_t_c = Rails.cache.fetch("all_ticket_categories", expires_in: 48.hours) do
        LynksServiceDesk::Category.all.map(&:hash_format)
      end

      respond_to do |format|
        format.json { render json: @a_t_c.to_json }
      end
    end

    def show
      respond_to do |format|
        format.json { render json: @ticket.hash_format.to_json }
      end
    end

    def update
      user_id = params.fetch(:user_id)
      new_assignee_id = params.fetch(:assignee_id)
      @ticket.assignee_id = new_assignee_id
      @ticket.save!
      @ticket.metrics.create!(
        user_id: user_id,
        action: "assigned_to_#{new_assignee_id}_by_#{user_id}"
      )

      respond_to do |format|
        format.json { render json: @ticket.reload.hash_format.to_json }
      end
    rescue ActionController::ParameterMissing => e
      respond_to do |format|
        format.json { render json: {message: e.message}.to_json, status: 403 }
      end
    end

    def create
      sub_category = find_sub_category
      sub_category_params = format_sub_category_options(sub_category)
      ticket = LynksServiceDesk::Ticket.new
      # add reference objects
      reference_params = params.require(:references).permit(*CONFIG.allowed_relation_objects_parameters)
      reference_params.each{|attr_name, attr_value| ticket.send("#{attr_name}=", attr_value)}
      ticket.creator_id = params[:creator_id] if params[:creator_id].present? 
      ticket.assignee_id = params[:assignee_id] if params[:assignee_id].present?
      ticket.generate!(sub_category, sub_category_params)
      ticket.reload
      respond_to do |format|
        format.json { render json: ticket.hash_format.to_json, status: 200 }
      end

    rescue ActionController::ParameterMissing,
      LynksServiceDesk::Exceptions::InvalidTicketParams,
      LynksServiceDesk::Exceptions::InvalidDataType => e

      respond_to do |format|
        format.json { render json: {message: e.message}.to_json, status: 403 }
      end

    rescue LynksServiceDesk::Exceptions::InvalidSubCategory => e
      respond_to do |format|
        format.json { render json: {message: e.message}.to_json, status: 404 } 
      end

    rescue => e
      respond_to do |format|
        format.json { render json: {message: e.message}.to_json, status: 500 } 
      end

    end

    def transition_state
      state_transition = params.fetch(:state_transition)
      @ticket.state_transition = state_transition
      @ticket.user_id = params[:user_id]
      @ticket.save!
      @ticket.reload
      respond_to do |format|
        format.json { render json: @ticket.hash_format.to_json, status: 200 }
      end
    rescue ActionController::ParameterMissing,
           NoMethodError,
           AASM::InvalidTransition => e
      respond_to do |format|
        format.json { render json: {
          message: "Allowed state transitions: #{@ticket.available_state_transitions.to_sentence}"},
          status: 403
        }
      end
    end

    def metrics
      action = params.fetch(:metric_action)
      @ticket.metrics.create!(
        action: action,
        user_id: params[:user_id]
      )

      respond_to do |format|
        format.json { render json: @ticket.hash_format.to_json, status: 200 }
      end
    rescue ActionController::ParameterMissing,
           LynksServiceDesk::Exceptions::InvalidMetric => e
      respond_to do |format|
        format.json { render json: {
          message: e.message},
          status: 403
        }
      end
    end

    def objects
      type = params.fetch(:type)
      if type.plural?
        params[:objects].each do |mini_param|
          @ticket.add_single_object(type.singularize, mini_param)
        end
      else
        @ticket.add_single_object(type, params)
      end
      respond_to do |format|
        format.json { render json: @ticket.reload.hash_format.to_json, status: 200 }
      end
    rescue ActionController::ParameterMissing,
           LynksServiceDesk::Exceptions::InvalidObject,
           LynksServiceDesk::Exceptions::ObjectNotInConfig => e
      respond_to do |format|
        format.json { render json: {
          message: e.message},
          status: 403
        }
      end
    end

    def set_ticket
      @ticket = LynksServiceDesk::Ticket.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      respond_to do |format|
        format.json { render json: {message: e.message}.to_json, status: 404 }
      end
    end

  end
end

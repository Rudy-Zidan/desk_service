module LynksServiceDesk
  class TicketsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_ticket, only: [:show, :update]

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
          @tickets.map{|t| t.hash_format}.to_json
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

      end
    end

    def update
      permitted_params = params.permit(:page, :limit, :scope)
    end

    def create
      category = find_sub_category

    rescue ActionController::RoutingError => e
      respond_to do |format|
        format.json { render json: {message: e.message}.to_json, status: 404 } 
      end
    rescue => e
      respond_to do |format|
        format.json { render json: {message: e.message}.to_json, status: 500 } 
      end
    end

    def find_sub_category
      sub_category_params = params.require(:sub_category).permit(:name, :slug)
      sub_category_slug = sub_category_params[:name].parameterize.underscore 
      sub_category_slug ||= sub_category_params[:name]
      sub_category = LynksServiceDesk::SubCategory.find_by_slug(sub_category_slug)
      if sub_category.blank?
        raise ActionController::RoutingError.new("Could not find sub category with slug #{sub_category_slug}")
      end
      sub_category
    end

    def set_ticket
      @ticket = LynksServiceDesk::Ticket.find(params[:id])
    end
  end
end

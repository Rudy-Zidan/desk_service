module LynksServiceDesk
  class TicketsController < ApplicationController

    before_action :set_ticket, only: [:show, :update, :create]

    CONFIG = LynksServiceDesk::Formatters::Config

    def index
      page = params[:page] || 1
      limit = params[:limit] || 30
      scope = params[:scope]

      if scope.present? && LynksServiceDesk::Ticket.respond_to?(scope)
        @tickets = LynksServiceDesk::Ticket.send(scope).page(page).per(limit)
        # although we can chain page and per, it is better this way
        # or else, the tickets will load all of the tickets in the scope which
        # may be a lot
      else
        @tickets = LynksServiceDesk::Ticket.page(page).per(limit)
      end

      respond_to do |format|
        format.json { render json: @tickets.map{|t| t.hash_format}.to_json}
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

    end

    def create

    end

    def set_ticket
      @ticket = LynksServiceDesk::Ticket.find(params[:id])
    end
  end
end

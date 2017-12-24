module LynksServiceDesk
  class TicketsController < ApplicationController

    before_action :set_ticket, only: [:show, :update, :create]

    def index

      respond_to do |format|

        format.json { render json: {}}
      end

    end

    def new
      @a_t_c = Rails.cache.fetch("all_ticket_categories", expires_in: 48.hours) do
        LynksServiceDesk::Category.all.map(&:hash_format)
      end

      respond_to do |format|
        format.json { render json: @a_t_c }
      end
    end

    def show
      respond_to do |format|
        format.json { render json: LynksServiceDesk::Category.all.map(&:hash) }
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

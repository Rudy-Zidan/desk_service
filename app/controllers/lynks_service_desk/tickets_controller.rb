module LynksServiceDesk
  class TicketsController < ApplicationController

    before_action :set_ticket, only: [:show, :update, :create]

    def index

      respond_to do |format|

        format.json { render json: {}}
      end

    end

    def new
      respond_to do |format|
        format.json { render json: LynksServiceDesk::Category.all.json_format }
      end
    end

    def show
      
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

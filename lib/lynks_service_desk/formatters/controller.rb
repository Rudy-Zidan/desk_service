module LynksServiceDesk
  module Formatters
    module Controller
      using LynksServiceDesk::Refinements

      def self.permitted_ticket_object_params(params)
        permitted_params = LynksServiceDesk.configuration.ticket_objects.map{|k,v| [k,v]}
        byebug
        return params.permit(permitted_params)
      end

      def self.query_tickets(params)
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
      end

    end
  end
end
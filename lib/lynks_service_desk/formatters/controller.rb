module LynksServiceDesk
  module Formatters
    module Controller
      using LynksServiceDesk::Refinements

      def self.permitted_ticket_object_params(params)
        permitted_params = LynksServiceDesk.configuration.ticket_objects.map{|k,v| [k,v]}
        byebug
        return params.permit(permitted_params)
      end


    end
  end
end
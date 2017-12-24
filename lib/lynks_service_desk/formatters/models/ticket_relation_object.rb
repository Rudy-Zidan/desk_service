module LynksServiceDesk
  module Formatters
    module Models
      module TicketRelationObject

        using LynksServiceDesk::Refinements

        def self.hash_format(ticket_relation_object)
          ticket_relation_object.attributes
        end

      end
    end
  end
end
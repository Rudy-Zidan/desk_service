module LynksServiceDesk
  module Formatters
    module Models
      module Ticket

        using LynksServiceDesk::Refinements


        def self.hash_format(ticket)
          {
            id: ticket.id,
            sub_category: ticket.sub_category.hash_format,
            category: ticket.sub_category.category.hash_format,
            priority: ticket.sub_category.priority.hash_format,
            creator_id: ticket.creator_id,
            assignee_id: ticket.assignee_id,
            state: ticket.state,
            body: ticket.body,
            created_at: ticket.created_at,
            updated_at: ticket.updated_at,
          }
        end

        def self.json_format(ticket)
          hash_format(ticket).to_json
        end

      end
    end
  end
end
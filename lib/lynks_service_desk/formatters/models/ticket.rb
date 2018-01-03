module LynksServiceDesk
  module Formatters
    module Models
      module Ticket

        using LynksServiceDesk::Refinements


        def self.hash_format(ticket)
          {
            id: ticket.id,
            priority: ticket.sub_category.priority.hash_format,
            creator_id: ticket.creator_id,
            assignee_id: ticket.assignee_id,
            state: ticket.state,
            body: ticket.body,
            objects: ticket.objects.map{|object| object.hash_format},
            created_at: ticket.created_at,
            updated_at: ticket.updated_at,
            sub_category: ticket.sub_category.hash_format,
            category: ticket.sub_category.category.hash_format,
          }
        end

      end
    end
  end
end
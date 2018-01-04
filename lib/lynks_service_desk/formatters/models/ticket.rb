module LynksServiceDesk
  module Formatters
    module Models
      module Ticket

        using LynksServiceDesk::Refinements


        def self.hash_format(ticket)
          {
            id: ticket.id,
            creator_id: ticket.creator_id,
            assignee_id: ticket.assignee_id,
            state: ticket.state,
            body: ticket.body,
            reference_objects: ticket.objects.map(&:hash_format),
            metrics: ticket.metrics.map(&:hash_format),
            priority: ticket.sub_category.priority.hash_format,
            sub_category: ticket.sub_category.hash_format,
            created_at: ticket.created_at,
            updated_at: ticket.updated_at,
            # category: ticket.sub_category.category.hash_format,
          }
        end

      end
    end
  end
end
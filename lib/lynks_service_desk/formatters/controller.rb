module LynksServiceDesk
  module Formatters
    module Controller
      using LynksServiceDesk::Refinements

      def self.permitted_ticket_object_params(params)
        permitted_params = LynksServiceDesk.configuration.ticket_objects.map{|k,v| [k,v]}
        return params.permit(permitted_params)
      end

      # deprecated. will reconsider later

      # def self.query_tickets(params)
      #   tickets = LynksServiceDesk::Ticket
      #   joint_tables = []
      #   ["ticket", "sub_category", "category", "metric"].each do |model_name|
      #     query_options[model_name].each do |attribute|
      #       to_look_for = params["#{model_name}_#{attribute}"].to_a + params["#{model_name}_#{attribute}s"].to_a
      #       next if to_look_for.blank?
      #       @tickets.send("where", "lynk")
      #     end
      #   end


      # end

      # def self.query_options
      #   {
      #     "ticket" => ["id", "assignee_id", "creator_id"],
      #     "sub_category" => ["id", "name", "slug"],
      #     "category" => ["id", "name", "slug"],
      #     "metric" => ["user_id", "action"],
      #     "no_tables" => ["metrics", "ticket_relation_objects"],
      #     "no_fields" => ["creator_id" "assignee_id"],
      #   }
      # end

    end
  end
end
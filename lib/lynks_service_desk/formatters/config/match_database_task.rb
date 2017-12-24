module LynksServiceDesk
  module Formatters
    module Config
      module MatchDatabaseTask
        using LynksServiceDesk::Refinements

        def self.priorities_to_match
          array = priorities.map do |name, no_of_hours| 
            {
              name: name.titleize, 
              slug: name.to_s.dehumanize,
              hours: no_of_hours.to_i
            }
          end
          return array
        end

        def self.categories_to_match
          array = tickets_types.keys.map do |category_name|
            {
              name: category_name.titleize,
              slug: category_name.dehumanize
            }
          end
          return array
        end

        def self.sub_categories_to_match
          array = []
          tickets_types.each do |category_name, sub_category_hash|
            sub_category_hash.each do |sub_category_name, priority_name|
              array << {
                name: sub_category_name.titleize,
                slug: sub_category_name.dehumanize,
                category_id: LynksServiceDesk::Category.find_by_slug(category_name.dehumanize).try(:id),
                priority_id: LynksServiceDesk::Priority.find_by_slug(priority_name.dehumanize).try(:id),
                options: options_for(sub_category_name).to_json
              }
            end
          end
          return array
        end

        def self.options_for(sub_category_name)
          values_hash = {}

          parameters = sub_categories_parameters[sub_category_name] || sub_categories_parameters[sub_category_name.dehumanize] || {}

          parameters_hash = {}
          
          parameters.each do |key, value|
            parameters_hash[key] = value.to_s
          end

          messages_hash = sub_categories_messages[sub_category_name] || sub_categories_messages[sub_category_name.dehumanize] || {} 

          values_hash = {parameters: parameters_hash, messages: messages_hash}
        end

        #instead of typing LynksServiceDesk.configuration every time
        def self.method_missing(meth, *args, &block)
          if LynksServiceDesk.configuration.respond_to? meth
            LynksServiceDesk.configuration.send(meth)
          else
            super
          end
        end

      end
    end
  end
end
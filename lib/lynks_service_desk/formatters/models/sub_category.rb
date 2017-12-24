module LynksServiceDesk
  module Formatters
    module Models
      module SubCategory

        using LynksServiceDesk::Refinements

        def self.hash_format(sub_category)
          {
            name: sub_category.name,
            slug: sub_category.slug,
            created_at: sub_category.created_at,
            updated_at: sub_category.updated_at,
            options: sub_category.options,
            category_name: sub_category.category.name,
            priority: sub_category.priority.hash_format
          }
        end

      end
    end
  end
end
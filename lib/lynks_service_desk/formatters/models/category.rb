module LynksServiceDesk
  module Formatters
    module Models
      module Category

        using LynksServiceDesk::Refinements

        def self.hash_format(category)
          {
            name: category.name,
            slug: category.slug,
            created_at: category.created_at,
            updated_at: category.updated_at,
            sub_categories: category.sub_categories.map(&:hash_format)
          }
        end

      end
    end
  end
end
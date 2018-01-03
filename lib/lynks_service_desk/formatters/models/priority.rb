module LynksServiceDesk
  module Formatters
    module Models
      module Priority

        using LynksServiceDesk::Refinements

        def self.hash_format(priority)
          {
            name: priority.name,
            slug: priority.slug,
            hours: priority[:hours]
          }
        end

      end
    end
  end
end
module LynksServiceDesk
  module Formatters
    module Config
      module MatchDatabaseTask
        using LynksServiceDesk::Refinements

        def priorities_to_match
          priorities.map do |name, no_of_hours| 
            {
              name: name.titleize, 
              slug: name.to_s.dehumanize,
              hours: hours.to_i
            }
          end
        end

        def categories_to_match

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
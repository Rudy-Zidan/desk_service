module LynksServiceDesk
  module Formatters
    module Config
      module MatchDatabaseTask
        using LynksServiceDesk::Refinements

        def active_priorities
          
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
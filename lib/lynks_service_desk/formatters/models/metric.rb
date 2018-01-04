module LynksServiceDesk
  module Formatters
    module Models
      module Metric

        using LynksServiceDesk::Refinements

        def self.hash_format(metric)
        	metric.attributes
        end

      end
    end
  end
end
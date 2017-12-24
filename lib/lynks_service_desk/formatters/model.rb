module LynksServiceDesk
  module Formatters
    module Model

      
      def self.hash_format(object)
        get_object_formatter(object).hash_format(object)
      end

      def self.get_object_formatter(object)
        return module_eval("LynksServiceDesk::Formatters::Models::#{object.class.to_s.split("::")[1]}")
      end

    end
  end
end
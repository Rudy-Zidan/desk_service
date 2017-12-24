module LynksServiceDesk
  module Formatters
    module Model

      def self.hash_format(object)
        get_object_formatter(object).hash_format(object)
      end

      def self.get_object_formatter(object)
        byebug
        return "LynksServiceDesk::Formatters::Models::#{object.class.to_s.split("::")[1]}".constantize
      end

    end
  end
end
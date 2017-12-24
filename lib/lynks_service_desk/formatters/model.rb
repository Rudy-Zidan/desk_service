module LynksServiceDesk
  module Formatters
    module Model

      [:hash_format, :json_format].each do |method_name|
        define_singleton_method method_name do |object|
          get_object_formatter(object).send(method_name, object)
        end
      end

      def self.get_object_formatter(object)
        return module_eval("LynksServiceDesk::Formatters::Models::#{object.class.to_s.split("::")[1]}")
      end

    end
  end
end
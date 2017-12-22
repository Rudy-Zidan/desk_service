module LynksServiceDesk
  module Formatter

    refine String do
      def dehumanize
        parameterize.gsub("-", "_")
      end

      def syminize
        dehumanize.to_sym
      end
    end

    refine Symbol do
      [:humanize, :titleize].each do |method_name|
        define_method method_name do
          to_s.send(method_name)
        end
      end
    end

    using LynksServiceDesk::Formatter

    def self.initial_state
      byebug
    end

  end
end
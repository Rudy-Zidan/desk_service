module LynksServiceDesk
  module Refinements

    refine String do
      def dehumanize
        parameterize.underscore
      end

      def syminize
        dehumanize.to_sym
      end

      def to_a
        return [self]
      end

      def plural?
        return self.pluralize == self
      end

      def singular?
        return self.singularize == self
      end

    end

    refine Symbol do
      [:humanize, :titleize].each do |method_name|
        define_method method_name do
          to_s.send(method_name)
        end
      end
    end

    refine Array do
      [:humanize, :titleize, :to_sym, :to_s].each do |method_name|
        define_method method_name do
          map{|element| element.send(method_name)}
        end
      end
    end


    using LynksServiceDesk::Refinements


  end
end
module LynksServiceDesk
  module Formatters
    module Config
 
      using LynksServiceDesk::Refinements

      def self.initial_state_symbol
        initial_state.syminize
      end

      def self.other_states
        # refining syminize in array does not work for some reason
        state_transitions.values.map(&:second).map{|s| s.syminize}.uniq
      end

      def self.test
        byebug
      end

      def self.state_transitions_hash_for_aasm
        array_of_hashes = []
        state_transitions.map do |k,v|
          values_hash = {}
          values_hash[:event_name] = k.syminize
          values_hash[:from] = v.first.to_a.map{|s| s.syminize}
          values_hash[:to] = v.second.syminize
          array_of_hashes << values_hash
        end
        array_of_hashes
      end


      def self.unopened_using_metrics?
        check_for_unopened_using_metrics
      end

      def self.save_state_transitions_metrics?
        record_state_transitions_as_metrics
      end

      def self.allowed_metrics
        allowed_metric_types.map{|s| s.syminize}
      end

      def self.allowed_relation_objects_attributes
        ticketable_classes.map{|class_name| [class_name.underscore + "_id", class_name.underscore + "_ids"]}.flatten
      end

      def self.allowed_relation_objects_parameters
        array = []
        self.allowed_relation_objects_attributes.each do |name|
          if name.to_s.last == "s"
            array << {"#{name}" => []}
          elsif name.to_s.last == "d"
            array << name
          end 
        end
        array
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
module LynksServiceDesk
  module Formatter
    using LynksServiceDesk::Refinements


    def self.initial_state_symbol
      initial_state.syminize
    end

    def self.other_states
      # refining syminize in array does not work for some reason
      state_transitions.values.map(&:second).map{|s| s.syminize}
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

    def self.method_missing(meth, *args, &block)
      if parent.configuration.respond_to? meth
        parent.configuration.send(meth)
      else
        super
      end
    end

    def self.new_using_metrics?
      check_for_new_using_metrics
    end

  end
end
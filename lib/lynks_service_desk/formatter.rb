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

    def self.method_missing(meth, *args, &block)
      if parent.configuration.respond_to? meth
        parent.configuration.send(meth)
      else
        super
      end
    end


  end
end
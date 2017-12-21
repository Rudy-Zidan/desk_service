module LynksServiceDesk
  class Configuration
    attr_accessor :ticketable_classes

    def initialize
      @ticketable_classes = []
    end

  end
end
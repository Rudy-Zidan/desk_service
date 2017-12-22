require "lynks_service_desk/engine"
require "lynks_service_desk/version"
require "lynks_service_desk/configuration"
require "lynks_service_desk/refinements"
require "lynks_service_desk/formatter"

module LynksServiceDesk
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end
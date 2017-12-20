$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lynks_service_desk/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lynks_service_desk"
  s.version     = LynksServiceDesk::VERSION
  s.authors     = ["Abdulla Mahmoud"]
  s.email       = ["aboodchei@gmail.com"]
  s.homepage    = "https://www.Lynks.com"
  s.summary     = "Ticketing System"
  s.description = "Ticketing System Microservice"

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"
  s.add_dependency "friendly_id", "~> 5.1.0"

  s.add_development_dependency "pg"
  s.add_development_dependency "yard"
  s.add_development_dependency "byebug"
  s.add_development_dependency "awesome_print"
  s.add_development_dependency "annotate"
  s.add_development_dependency "puma"
  s.add_development_dependency "rails-erd"
end

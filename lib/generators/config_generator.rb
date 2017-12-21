class ConfigGenerator < Rails::Generators::Base
  def create_initializer_file
    create_file "config/initializers/lynks_service_desk_config.rb",
    "# Add initialization content here"
  end
end
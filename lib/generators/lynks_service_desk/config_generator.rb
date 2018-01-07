module LynksServiceDesk
class ConfigGenerator < Rails::Generators::Base
  def create_initializer_file
    create_file "config/initializers/lynks_service_desk_config.rb",
    %s(LynksServiceDesk.configure do |config|

  # config.ticketable_classes expects an array of models
  # example: ["Order", "Item", "ItemInstance"]
  # default: []
  config.ticketable_classes = []


  # config.priorities expects a hash containing name, and number of hours
  # default:
  # {
  #   "high" => 12,
  #   "medium" => 24,
  #   "low" => 48
  # }
  # 
  # config.priorities = {
  #  "high" => 12,
  #  "medium" => 24,
  #  "low" => 48
  # }


  # config.tickets_types expects categories, sub_categories, and priorities
  # example:
  # {
  #   "Operations" => {
  #     "Price Change" => "high",
  #     "Another Sub Category" => "low"
  #   },
  #   "Finance" => {
  #     "Refund" => "high",
  #     "Another Sub Category" => "low"
  #   }
  # }
  config.tickets_types = {}



  # config.sub_categories_parameters expects sub_categories, and parameters names
  # and types that will be allowed.
  # note: all these fields are mandatory
  # example:
  # {
  #   "Price Change" =>
  #   {
  #     "price_before" => Integer,
  #     "price_after" => Float,
  #     "due_date" => DateTime,
  #     "name" => String
  #   }
  # }
  config.sub_categories_parameters = {}


  # config.sub_categories_messages expects sub_categories, locales, and the message
  # example:
  # {
  #   "Price Change" =>
  #   {
  #     en: "Hello %name. Price has changed. Was %price_before, now is %price_after.
  #       Please pay before %due_date",
  #     es: "Hola %name. El precio ha cambiado. Fue %price_before, ahora es %price_after.
  #        Por favor pague antes %due_date",
  #   }
  # }
  # 
  config.sub_categories_messages = {}


  # config.record_state_transitions_as_metrics expects a boolean
  # toggles whether metrics are created upon state transition or not
  # default true
  # config.record_state_transitions_as_metrics = true


  # config.allowed_metric_types expects an array of strings
  # example:
  # ["First view", "First customer contact"]
  config.allowed_metric_types = []


  # config.initial_state expects a string
  # this will be the default state of any new ticket
  # default: "Open"
  # config.initial_state = "Open"


  # config.check_for_unopened_using_metrics expects a boolean
  # this will default all tickets with no metrics to the state "new"
  # protip: set this to false if your initial state is "new"
  # default: true
  # config.check_for_unopened_using_metrics = true


  # config.state_transitions expects a hash
  # default: { "Mark as on hold" => ["Open", "On Hold"],
  #        "Close" => [["Open", "On Hold"], "Closed"]}
  # config.state_transitions = { 
  #       "Mark as on hold" => ["Open", "On Hold"],
  #       "Close" => [["Open", "On Hold"], "Closed"]
  #     }

  # config.custom_scopes expects a hash
  # default: { "Unresolved" => ["Open", "On Hold"],
  #        "Resolved" => "Closed"}
  # config.custom_scopes = {
  #       "Unresolved" => ["Open", "On Hold"],
  #       "Resolved" => "Closed"
  #     }

  # config.ticket_objects expects a hash
  # default: { "Comment" => [:user_id, :body] }
  # note: :created_at is automatically added
  # config.ticket_objects = { "Comment" => [:user_id, :body] }

end
    )

  end
end
end
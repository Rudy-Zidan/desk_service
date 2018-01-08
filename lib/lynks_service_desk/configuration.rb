module LynksServiceDesk
  class Configuration
    attr_accessor :ticketable_classes, :priorities, :tickets_types,
                  :sub_categories_parameters, :sub_categories_messages,
                  :record_state_transitions_as_metrics,
                  :allowed_metric_types, :initial_state,
                  :check_for_unopened_using_metrics,
                  :state_transitions, :ticket_objects, :custom_scopes

    def initialize
      @ticketable_classes = []
      @priorities = {
       "high" => 12,
       "medium" => 24,
       "low" => 48
      }
      @tickets_types = {}
      @sub_categories_parameters = {}
      @sub_categories_messages = {}
      @record_state_transitions_as_metrics = true
      @allowed_metric_types = []
      @initial_state = "Open"
      @check_for_unopened_using_metrics = true
      @state_transitions = { 
          "Mark as on hold" => ["Open", "On Hold"],
      "Close" => [["Open", "On Hold"], "Closed"]
      }
      @custom_scopes = {
      "Unresolved" => ["Open", "On Hold"],
      "Resolved" => "Closed"
      }
      @ticket_objects = {
        "Comment" => [:user_id, :body]
      }
    end

    # @ticketable_classes expects an array of models
    # example: ["Order", "Item", "ItemInstance"]
    # default: []

    # @priorities expects a hash containing name, and number of hours
    # default:
    # {
  #   "high" => 12,
  #   "medium" => 24,
  #   "low" => 48
  # }
  # 

  # @tickets_types expects categories, sub_categories, and priorities
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
  # default: {}

  # @sub_categories_parameters expects sub_categories, and parameters names
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
  # default: {}

  # @sub_categories_messages expects sub_categories, locales, and the message
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
  # default: {}
  # 
  # 

  # @record_state_transitions_as_metrics expects a boolean
  # toggles whether metrics are created upon state transition or not
  # default true


  # @allowed_metric_types expects an array of strings
  # example:
  # ["First view", "First customer contact"]
  # default: []

  # @initial_state expects a string
  # this will be the default state of any new ticket
  # default: "Open"

  # @check_for_unopened_using_metrics expects a boolean
  # this will default all tickets with no metrics to the state "unopened"
  # default: true
  # protip: set this to false if your initial state is "unopened"

  # @state_transitions expects a hash
  # default: { "Mark as on hold" => ["Open", "On Hold"],
  #        "Close" => [["Open", "On Hold"], "Closed"]}

  # @custom_scopes expects a hash
  # default: { "Unresolved" => ["Open", "On Hold"],
  #        "Resolved" => "Closed"}

  # @ticket_objects expects a hash
  # default:       @ticket_objects = {
  #   "Comment" => [:user_id, :body] }
  # note: :created_at is automatically added

  end
end
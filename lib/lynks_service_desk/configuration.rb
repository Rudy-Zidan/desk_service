module LynksServiceDesk
  class Configuration
    attr_accessor :ticketable_classes, :priorities, :tickets_types,
                  :sub_categories_parameters, :sub_categories_messages

    def initialize
      @ticketable_classes = []
      @priorities = {}
      @tickets_types = {}
      @sub_categories_parameters = {}
      @sub_categories_messages = {}
    end

    # @ticketable_classes expects an array of models
    # example: Order, Item, ItemInstance

    # @priorities expects a hash containing name, and number of hours
    # example:
    # {
	# 	"high" => 12,
	# 	"medium" => 24,
	# 	"low" => 48
	# }

	# @tickets_types expects categories, sub_categories, and priorities
	# example:
	# {
	# 	"Operations" => {
	# 		"Price Change" => "high",
	# 		"Another Sub Category" => "low"
	# 	},
	# 	"Finance" => {
	# 		"Refund" => "high",
	# 		"Another Sub Category" => "low"
	#   }
	# }

	# @sub_categories_parameters expects sub_categories, and parameters names
	# and types that will be allowed.
	# note: all these fields are mandatory
	# example:
	# {
	# 	"Price Change" =>
	# 	{
	# 		"price_before" => Integer,
	# 		"due_date" => DateTime,
	# 		"name" => String
	# 	}
	# }

	# @sub_categories_messages expects sub_categories, locales, and the message
	# example:
	# {}





  end
end
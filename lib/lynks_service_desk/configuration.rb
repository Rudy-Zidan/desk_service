module LynksServiceDesk
  class Configuration
    attr_accessor :ticketable_classes, :priorities, :tickets_types,
    			  :sub_categories_options

    def initialize
      @ticketable_classes = []
      @priorities = {}
      @tickets_types = {}
      @sub_categories_options = {}
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



  end
end
module LynksServiceDesk
	module Exceptions

		class InvalidTicketParams < StandardError; end
		class InvalidDataType < StandardError; end
		class InvalidSubCategory < StandardError; end
		class InvalidMetric < StandardError; end
	end
end
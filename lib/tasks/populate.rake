desc "Populate categories and sub categories"

task populate: :environment do

	priorities = {
		"Low" => 48,
		"Medium" => 24,
		"High" => 12
	}

	priorities.each do |name, hours|
		LynksServiceDesk::Priority.find_by_name(name) || LynksServiceDesk::Priority.create(name: name, hours: hours)
	end

	values_hash = {
		"Operations" => {
			"Price change" => "medium",
			"Out of stock" => "medium",
			"Clearance" => "medium",
			"Customs Category" => "medium",
			"Missing Specs" => "medium",
			"SLA" => "medium",
			"Domestic Shipping inside USA per store" => "medium",
			"Item's weight" => "medium",
			"Missing" => "medium",
			"Cancelled by seller" => "medium",
			"Prohibited" => "medium",
			"Webiste not trusted" => "medium",
			"Payment rejection" => "medium",
			"Seller not trusted" => "medium",
			"Outbid" => "medium",
			"Mismatched" => "medium",
			"Damaged" => "medium",
			"Promo codes application" => "medium",
		}
	}
end

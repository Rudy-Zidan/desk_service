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
			"" => ""
		}
	}

end

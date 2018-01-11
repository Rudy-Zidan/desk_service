namespace :lynks_service_desk do
	desc "Match database with updated configuration"

	task match_database_with_configuration: :environment do
		using LynksServiceDesk::Refinements
		formatter = LynksServiceDesk::Formatters::Config::MatchDatabaseTask

		["Priority", "Category", "SubCategory"].each do |model_name|
			puts "Matching #{model_name.pluralize}"
			class_name = "LynksServiceDesk::#{model_name}".constantize
			puts "Fetching configuration for #{model_name.pluralize}"
			array_to_match = formatter.send(model_name.underscore.pluralize + "_to_match")
			array_to_match.each do |value_hash|
				db_object = class_name.find_by_slug(value_hash[:slug]) || class_name.new
				value_hash.each do |attribute, value|
					db_object.send("#{attribute}=", value)
				end
				db_object.save!
			end
			puts "Deactivating #{model_name.pluralize} not in configuration"
			class_name.where.not(slug: array_to_match.map{|value_hash| value_hash[:slug]}).update_all(active: false)
		end

	end
end
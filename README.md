# LynksServiceDesk
Fully Configurable Ticketing API Engine, with categories, sub categories, states, priorities, metrics, relation objects, custom objects, and more!

## Configuration
### Initialization
Add this line to your application's Gemfile:

```ruby
gem 'lynks_service_desk'
```

Run the following
```ruby
rake lynks_service_desk:install:migrations
rake db:migrate
```
Create the configuration file
```ruby
rails generate lynks_service_desk:config
```

This creates a configuration file, and can be found as `config/initializers/lynks_service_desk_config.rb`


## Configuration
Inside `config/initializers/lynks_service_desk_config.rb`, you will find the following options available:

```ruby 
config.ticketable_classes
# This expects an array of classes. 
Example = ["Order", "User", "Item"]
Default = []
```

```ruby
config.priorities
# This expects a hash, where the key is the priority's name,
# and the value is the number of hours allocated
Example = {
	"Priority Name": no_of_hours
}
Default = {
	"high" => 12,
	"medium" => 24,
	"low" => 48
}
```

```ruby
config.tickets_types
# This expects a hash in the following format
{
	"Category Name" => {
		"Sub Category Name" => "Priority Name"
	}
}
Default = {}
```

```ruby
config.sub_categories_parameters
# This expects a hash in the following format
{
	"Sub Category Name" => {
		"parameter_name" => Datatype
	}
}
# Available data types: String, DateTime, Date, Integer, Float
Default = {}
```

```ruby
config.sub_categories_messages
# This expects a hash in the following format
{
	"Sub Category Name" => {
		locale: "Hello %name"
	}
}
# words preceded with a '%' sign will be subbed with its value in config.sub_categories_parameters
Default = {}
```

```ruby
config.record_state_transitions_as_metrics
# This expects a boolean
# Toggles whether metrics are created upon state transition or not
Default = true
```

```ruby
config.allowed_metric_types
# This expects an array of allowed metrics
Example = ["First view", "First customer contact"]
Default = []
```

```ruby
config.initial_state
# This expects a string
Example = "Awaiting reply"
Default = "Open"
```

```ruby
config.check_for_unopened_using_metrics
# This expects a boolean
# Setting this to true, will default all tickets with no metrics yet to the state "unopened".
# There is no need to set this as true if your initial state is already "unopened"
Default = true
```

```ruby
config.state_transitions
# This expects a state transitions hash in the following format
Example = {
	"Transition Action Name 1" => ["From State Name", "To State Name"],
	"Transition Action Name 2" => [["From State Name 1", "From State Name 2"],"To State Name 2"]
}
Default = {
	"Mark as on hold" => ["Open", "On Hold"],
	"Close" => [["Open", "On Hold"], "Closed"]
}
```

```ruby
config.custom_scopes
# This expects a custom scopes hash in the following format
Example = {
	"Scope Name" => ["State Name 1", "State Name 2"],
	"Another Scope Name" => "State Name"
}
Default = {
	"Unresolved" => ["Open", "On Hold"],
	"Resolved" => "Closed"
}
```

```ruby
config.ticket_objects
# This expects a hash of custom objects
# Note: created_at is automatically added :)
Example = {
	"Object Name" => [:param_1, :param_2]
}
Default = {
	"Comment" => [:user_id, :body]
}
```

Do not forget to run `rake lynks_service_desk:match_database_with_configuration` after any and all changes to your configuration file in order for the database to be updated!

## Documentation & API
For more details, [check out the wiki](https://github.com/Lynks/LynksServiceDesk/wiki)

## Database
![Who removed the erd image file ? :( ](erd.png)

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

## Paths
### Create New Ticket
`POST - /tickets.json `

```json
{
	"creator_id": 1,
	"assignee_id": 2,
	*"sub_category": {
		**"name": "Price Change",
		**"slug": "price-change",
		*"options": {
			*"price_before": 10,
			*"price_after": 10.5,
			*"due_date": "1-1-2017",
			*"name": "hello"
		}
	},
	"references": {
		"order_id": 1,
		"item_ids": [1,2,3]
	}
}
```
Starred keys are required.
You can either send a sub category name, or a slug.
Options must match the type declared in the config file
Reference objects can either be singular, in the form `class_name_id`, or multiple, in the form `class_name_ids`

Responses:
200 OK
```json
{
    "id": 27,
    "creator_id": 1,
    "assignee_id": 2,
    "state": "unopened",
    "available_state_transitions": [
        "mark_as_on_hold",
        "close"
    ],
    "available_metric_actions": [
        "first_view",
        "first_customer_contact"
    ],
    "body": {
        "values": {
            "price_before": 10,
            "price_after": 10.5,
            "due_date": "2017-01-01T00:00:00.000+00:00",
            "name": "hello"
        },
        "messages": {
            "en": "Hello hello. Price has changed. Was 10, now is 10.5.\n        Please pay before 2017-01-01T00:00:00+00:00",
            "es": "Hola hello. El precio ha cambiado. Fue 10, ahora es 10.5.\n         Por favor pague antes 2017-01-01T00:00:00+00:00"
        },
        "objects": {}
    },
    "reference_objects": [
        {
            "id": 57,
            "ticket_id": 27,
            "relation_object_id": 1,
            "relation_object_type": "Order",
            "created_at": "2018-01-07T23:29:47.904Z",
            "updated_at": "2018-01-07T23:29:47.904Z"
        }
    ],
    "metrics": [],
    "priority": {
        "name": "High",
        "slug": "high",
        "hours": 12
    },
    "sub_category": {
        "name": "Price Change",
        "slug": "price_change",
        "created_at": "2017-12-24T05:38:51.632Z",
        "updated_at": "2018-01-04T03:58:07.752Z",
        "options": {
            "parameters": {
                "price_before": "Integer",
                "price_after": "Float",
                "due_date": "DateTime",
                "name": "String"
            },
            "messages": {
                "en": "Hello %name. Price has changed. Was %price_before, now is %price_after.\n        Please pay before %due_date",
                "es": "Hola %name. El precio ha cambiado. Fue %price_before, ahora es %price_after.\n         Por favor pague antes %due_date"
            }
        },
        "category_name": "Operations",
        "priority": {
            "name": "High",
            "slug": "high",
            "hours": 12
        }
    },
    "created_at": "2018-01-07T23:29:47.869Z",
    "updated_at": "2018-01-07T23:29:47.869Z"
}
```

403 Forbidden - Missing Parameter, or invalid parameter type
```json
{
	message: "Missing, or invalid parameter X"
}
```
404 Not Found - Could not find sub category with name/slug
```json
{
	message: "Could not find sub category with slug slug"
}
```
## Installation

And then execute:
```bash
$ bundle install
```

## Database
![Who removed the erd image file ? :( ](erd.png)

## Contributing
Contribution directions go here.

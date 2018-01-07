# LynksServiceDesk


## Usage
```
createdb lynks_service_desk_development
rake app:db:migrate
rake app:populate
```

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
rails generate lynks_service_desk:config
```

## Paths

### Create New Ticket
`POST - '/tickets.json' `

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

## Installation

And then execute:
```bash
$ bundle install
```

## Database
![Who removed the erd image file ? :( ](erd.png)

## Contributing
Contribution directions go here.

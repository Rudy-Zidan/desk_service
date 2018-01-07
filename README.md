# LynksServiceDesk

## Database
![Who removed the erd image file ? :( ](erd.png)

## Usage
```
createdb lynks_service_desk_development
rake app:db:migrate
rake app:populate
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
Add this line to your application's Gemfile:

```ruby
gem 'lynks_service_desk'
```

And then execute:
```bash
$ bundle install
```

## Contributing
Contribution directions go here.

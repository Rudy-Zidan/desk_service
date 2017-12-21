desc "Match database with updated configuration"

task match_database_with_configuration: :environment do

	

	priorities.each do |name, hours|
		LynksServiceDesk::Priority.find_by_name(name) || LynksServiceDesk::Priority.create(name: name, hours: hours)
	end

	values_hash = {
		"Operations" => {
			"Price change" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Out of stock" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Clearance" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Customs Category" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Missing Specs" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"SLA" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Domestic Shipping inside USA per store" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Item's weight" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Missing" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Cancelled by seller" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Prohibited" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Webiste not trusted" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Payment rejection" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Seller not trusted" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Outbid" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Mismatched" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Damaged" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
			"Promo codes application" => {
				priority: "medium",
				options: {
					price_before: {
						class: Integer
					},
					price_after: {
						class: [DateTime, Integer]
					}
				}
			},
		}
	}


end

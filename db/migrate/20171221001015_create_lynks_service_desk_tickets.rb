class CreateLynksServiceDeskTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :lynks_service_desk_tickets do |t|
      t.references :category, foreign_key: { to_table: "lynks_service_desk_categories" }
      t.references :sub_category, foreign_key: { to_table: "lynks_service_desk_sub_categories" }
      t.integer :creator_id
      t.integer :assignee_id
      t.string :state
      t.json :body

      t.timestamps
    end
    add_index :lynks_service_desk_tickets, :creator_id
    add_index :lynks_service_desk_tickets, :assignee_id
    add_index :lynks_service_desk_tickets, :state
  end
end
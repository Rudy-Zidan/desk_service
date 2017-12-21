class CreateLynksServiceDeskTicketObjects < ActiveRecord::Migration[5.1]
  def change
    create_table :lynks_service_desk_ticket_objects do |t|
      t.references :ticket, foreign_key: { to_table: "lynks_service_desk_tickets" }
      t.string :type
      t.json :body

      t.timestamps
    end
    add_index :lynks_service_desk_ticket_objects, :type
  end
end

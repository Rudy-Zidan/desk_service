class CreateLynksServiceDeskTicketRelationObjects < ActiveRecord::Migration[5.1]
  def change
    create_table :lynks_service_desk_ticket_relation_objects do |t|
      t.references :ticket, foreign_key: { to_table: "lynks_service_desk_tickets" }
      t.integer :relation_object_id
      t.string :relation_object_type

      t.timestamps
    end

    add_index :lynks_service_desk_ticket_relation_objects, [:relation_object_id, :relation_object_type], name: :index_lynks_service_desk_relation_object_relation_object

  end
end

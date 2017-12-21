class CreateLynksServiceDeskMetrics < ActiveRecord::Migration[5.1]
  def change
    create_table :lynks_service_desk_metrics do |t|
      t.references :ticket, foreign_key: { to_table: "lynks_service_desk_tickets" }
      t.integer :user_id
      t.string :action, null: false
      t.string :duration_from_previous, "duration", null: false
      t.string :duration_from_created_at, "duration", null: false

      t.timestamps
    end
  end
end

class CreateLynksServiceDeskMetrics < ActiveRecord::Migration[5.1]
  def change
    create_table :lynks_service_desk_metrics do |t|
      t.references :ticket, foreign_key: { to_table: "lynks_service_desk_tickets" }
      t.integer :user_id
      t.string :action, null: false
      t.integer :duration_from_previous, null: false
      t.integer :duration_from_created_at, null: false

      t.timestamps
    end
  end
end

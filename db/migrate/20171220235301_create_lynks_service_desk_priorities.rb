class CreateLynksServiceDeskPriorities < ActiveRecord::Migration[5.1]
  def change
    create_table :lynks_service_desk_priorities do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.integer :hours, null: false, default: 24
      t.boolean :active, null: false, default: true

      t.timestamps
    end
    add_index :lynks_service_desk_priorities, :slug
  end
end

class CreateLynksServiceDeskSubCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :lynks_service_desk_sub_categories do |t|
      t.references :category, foreign_key: { to_table: "lynks_service_desk_categories" }
      t.string :name, null: false, default: ""
      t.string :slug, null: false, default: ""
      t.boolean :active, null: false, default: true

      t.timestamps
    end
    add_index :lynks_service_desk_sub_categories, :slug
    add_index :lynks_service_desk_sub_categories, :active
  end
end

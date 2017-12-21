# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171221004935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lynks_service_desk_categories", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "slug", default: "", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_lynks_service_desk_categories_on_active"
    t.index ["slug"], name: "index_lynks_service_desk_categories_on_slug"
  end

  create_table "lynks_service_desk_metrics", force: :cascade do |t|
    t.bigint "ticket_id"
    t.integer "user_id"
    t.string "action", null: false
    t.integer "duration_from_previous", null: false
    t.integer "duration_from_created_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_lynks_service_desk_metrics_on_ticket_id"
  end

  create_table "lynks_service_desk_priorities", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.integer "hours", default: 24, null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_lynks_service_desk_priorities_on_slug"
  end

  create_table "lynks_service_desk_sub_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "priority_id"
    t.string "name", default: "", null: false
    t.string "slug", default: "", null: false
    t.boolean "active", default: true, null: false
    t.json "options", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_lynks_service_desk_sub_categories_on_active"
    t.index ["category_id"], name: "index_lynks_service_desk_sub_categories_on_category_id"
    t.index ["priority_id"], name: "index_lynks_service_desk_sub_categories_on_priority_id"
    t.index ["slug"], name: "index_lynks_service_desk_sub_categories_on_slug"
  end

  create_table "lynks_service_desk_ticket_objects", force: :cascade do |t|
    t.bigint "ticket_id"
    t.string "type"
    t.json "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_lynks_service_desk_ticket_objects_on_ticket_id"
    t.index ["type"], name: "index_lynks_service_desk_ticket_objects_on_type"
  end

  create_table "lynks_service_desk_ticket_relation_objects", force: :cascade do |t|
    t.bigint "ticket_id"
    t.integer "relation_object_id", null: false
    t.string "relation_object_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["relation_object_id", "relation_object_type"], name: "index_lynks_service_desk_relation_object_relation_object"
    t.index ["ticket_id"], name: "index_lynks_service_desk_ticket_relation_objects_on_ticket_id"
  end

  create_table "lynks_service_desk_tickets", force: :cascade do |t|
    t.bigint "sub_category_id"
    t.integer "creator_id"
    t.integer "assignee_id"
    t.string "state", null: false
    t.json "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_lynks_service_desk_tickets_on_assignee_id"
    t.index ["creator_id"], name: "index_lynks_service_desk_tickets_on_creator_id"
    t.index ["state"], name: "index_lynks_service_desk_tickets_on_state"
    t.index ["sub_category_id"], name: "index_lynks_service_desk_tickets_on_sub_category_id"
  end

  add_foreign_key "lynks_service_desk_metrics", "lynks_service_desk_tickets", column: "ticket_id"
  add_foreign_key "lynks_service_desk_sub_categories", "lynks_service_desk_categories", column: "category_id"
  add_foreign_key "lynks_service_desk_sub_categories", "lynks_service_desk_priorities", column: "priority_id"
  add_foreign_key "lynks_service_desk_ticket_objects", "lynks_service_desk_tickets", column: "ticket_id"
  add_foreign_key "lynks_service_desk_ticket_relation_objects", "lynks_service_desk_tickets", column: "ticket_id"
  add_foreign_key "lynks_service_desk_tickets", "lynks_service_desk_sub_categories", column: "sub_category_id"
end

# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160329001855) do

  create_table "aircrafts", force: :cascade do |t|
    t.string   "plate_number"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.time     "flight_hours",   default: '2000-01-01 00:00:00'
    t.date     "beginning_time"
  end

  create_table "alerts", force: :cascade do |t|
    t.integer  "best_before"
    t.float    "minimum_quantity"
    t.integer  "deteriorating_item_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "alerts", ["deteriorating_item_id"], name: "index_alerts_on_deteriorating_item_id"

  create_table "components", force: :cascade do |t|
    t.string   "name"
    t.integer  "system_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.time     "flight_hours",   default: '2000-01-01 00:00:00'
    t.date     "beginning_time"
  end

  add_index "components", ["system_id"], name: "index_components_on_system_id"

  create_table "deteriorating_items", force: :cascade do |t|
    t.string   "name"
    t.string   "unit"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "specification"
  end

  create_table "expiration_dates", force: :cascade do |t|
    t.date     "date"
    t.integer  "quantity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "expiration_dates", ["quantity_id"], name: "index_expiration_dates_on_quantity_id"

  create_table "first_inspections", force: :cascade do |t|
    t.integer  "time_limit"
    t.string   "unit_tl"
    t.integer  "surplus"
    t.string   "unit_sp"
    t.string   "last_inspection"
    t.integer  "component_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "inspection_id"
    t.integer  "alert_before"
    t.string   "unit_ab"
    t.integer  "aircraft_id"
  end

  add_index "first_inspections", ["component_id"], name: "index_first_inspections_on_component_id"

  create_table "flight_sheets", force: :cascade do |t|
    t.time     "departure_time"
    t.time     "arrival_time"
    t.time     "flight_time"
    t.integer  "aircraft_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "flight_sheets", ["aircraft_id"], name: "index_flight_sheets_on_aircraft_id"

  create_table "inspections", force: :cascade do |t|
    t.string   "name"
    t.integer  "component_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "inspections", ["component_id"], name: "index_inspections_on_component_id"

  create_table "intermediate_inspections", force: :cascade do |t|
    t.integer  "component_id"
    t.integer  "inspection_id"
    t.integer  "time_limit"
    t.string   "unit_tl"
    t.integer  "surplus"
    t.string   "unit_sp"
    t.string   "last_inspection"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "alert_before"
    t.string   "unit_ab"
    t.integer  "aircraft_id"
  end

  add_index "intermediate_inspections", ["component_id"], name: "index_intermediate_inspections_on_component_id"

  create_table "periodical_inspections", force: :cascade do |t|
    t.integer  "time_limit"
    t.string   "unit_tl"
    t.integer  "surplus"
    t.string   "unit_sp"
    t.string   "last_inspection"
    t.integer  "inspection_id"
    t.integer  "component_id"
    t.integer  "alert_before"
    t.string   "unit_ab"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "aircraft_id"
  end

  add_index "periodical_inspections", ["component_id"], name: "index_periodical_inspections_on_component_id"

  create_table "quantities", force: :cascade do |t|
    t.float    "number"
    t.integer  "deteriorating_item_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "quantities", ["deteriorating_item_id"], name: "index_quantities_on_deteriorating_item_id"

  create_table "scheduled_inspections", force: :cascade do |t|
    t.integer  "component_id"
    t.integer  "flight_hours"
    t.integer  "start_at"
    t.integer  "inspection_at"
    t.integer  "finish_at"
    t.boolean  "done",          default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "inspection"
  end

  add_index "scheduled_inspections", ["component_id"], name: "index_scheduled_inspections_on_component_id"

  create_table "second_inspections", force: :cascade do |t|
    t.integer  "time_limit"
    t.string   "unit_tl"
    t.integer  "surplus"
    t.string   "unit_sp"
    t.string   "last_inspection"
    t.integer  "inspection_id"
    t.integer  "component_id"
    t.integer  "alert_before"
    t.string   "unit_ab"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "aircraft_id"
  end

  add_index "second_inspections", ["component_id"], name: "index_second_inspections_on_component_id"

  create_table "special_tools", force: :cascade do |t|
    t.string   "name"
    t.integer  "inspection_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "special_tools", ["inspection_id"], name: "index_special_tools_on_inspection_id"

  create_table "systems", force: :cascade do |t|
    t.string   "name"
    t.integer  "aircraft_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "systems", ["aircraft_id"], name: "index_systems_on_aircraft_id"

  create_table "twelve_months_inspections", force: :cascade do |t|
    t.integer  "time_limit"
    t.string   "unit_tl"
    t.integer  "surplus"
    t.string   "unit_sp"
    t.string   "last_inspection"
    t.integer  "inspection_id"
    t.integer  "component_id"
    t.integer  "alert_before"
    t.string   "unit_ab"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "aircraft_id"
  end

  add_index "twelve_months_inspections", ["component_id"], name: "index_twelve_months_inspections_on_component_id"

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

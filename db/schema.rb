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

ActiveRecord::Schema.define(version: 20160227222651) do

  create_table "aircrafts", force: :cascade do |t|
    t.string   "plate_number"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.time     "flight_hours", default: '2000-01-01 00:00:00'
  end

  create_table "components", force: :cascade do |t|
    t.string   "name"
    t.integer  "system_id"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.time     "flight_hours", default: '2000-01-01 00:00:00'
  end

  add_index "components", ["system_id"], name: "index_components_on_system_id"

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
  end

  add_index "intermediate_inspections", ["component_id"], name: "index_intermediate_inspections_on_component_id"

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

end

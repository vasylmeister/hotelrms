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

ActiveRecord::Schema.define(version: 20170302115623) do

  create_table "bed_types", force: :cascade do |t|
    t.string "name"
    t.float  "width"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "first_name",   null: false
    t.string   "last_name",    null: false
    t.string   "phone_number", null: false
    t.string   "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "deleted_at"
    t.index ["last_name"], name: "index_clients_on_last_name"
    t.index ["phone_number", "email"], name: "index_clients_on_phone_number_and_email", unique: true
  end

  create_table "private_beds", force: :cascade do |t|
    t.integer "room_id"
    t.index ["room_id"], name: "index_private_beds_on_room_id"
  end

  create_table "room_bed_types", force: :cascade do |t|
    t.integer "room_id"
    t.integer "bed_type_id"
    t.index ["bed_type_id"], name: "index_room_bed_types_on_bed_type_id"
    t.index ["room_id"], name: "index_room_bed_types_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.string   "size"
    t.string   "room_type"
    t.integer  "pax"
    t.integer  "max_pax"
    t.integer  "beds"
    t.integer  "extra_beds",    default: 0
    t.integer  "bathrooms"
    t.string   "bathroom_type"
    t.integer  "floor"
    t.text     "description"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end

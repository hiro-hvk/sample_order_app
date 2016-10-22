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

ActiveRecord::Schema.define(version: 20161021172247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "costs", force: :cascade do |t|
    t.integer  "subject_id"
    t.string   "material"
    t.string   "product"
    t.string   "pressure"
    t.string   "size"
    t.string   "quantity"
    t.string   "hvk"
    t.string   "fujii"
    t.string   "imamoto"
    t.string   "selling_price"
    t.text     "remarks"
    t.string   "sign"
    t.string   "product_model"
    t.string   "unit"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "costs", ["subject_id"], name: "index_costs_on_subject_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "title"
    t.text     "remarks"
    t.integer  "order_number"
    t.string   "delivery_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "costs", "subjects"
end

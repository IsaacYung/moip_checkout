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

ActiveRecord::Schema.define(version: 20170402145924) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.integer  "external_id"
    t.string   "fullname"
    t.string   "email"
    t.json     "phone"
    t.date     "birth_date"
    t.string   "tax_document"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "external_id"
    t.integer  "customers_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "external_id"
    t.integer  "orders_id"
    t.string   "status"
    t.json     "amount"
    t.integer  "instalment_count"
    t.json     "funding_instrument"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "product_movements", force: :cascade do |t|
    t.integer  "products_id"
    t.integer  "orders_id"
    t.integer  "quantity"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "product_name"
    t.integer  "quantity"
    t.string   "detail"
    t.integer  "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "pic"
  end

end

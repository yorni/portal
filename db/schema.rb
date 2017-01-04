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

ActiveRecord::Schema.define(version: 20170104160509) do

  create_table "branches", force: :cascade do |t|
    t.string   "name",       limit: 30
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "code",       limit: 4
  end

  create_table "contracts", force: :cascade do |t|
    t.string   "number",     limit: 12
    t.date     "date"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "institutions", force: :cascade do |t|
    t.string   "name",       limit: 50
    t.integer  "branch_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "code",       limit: 9
  end

  add_index "institutions", ["branch_id"], name: "index_institutions_on_branch_id"

  create_table "order_products", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.date     "date"
    t.decimal  "count_pr",                precision: 8, scale: 2
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "description", limit: 100
  end

  add_index "order_products", ["order_id"], name: "index_order_products_on_order_id"
  add_index "order_products", ["product_id"], name: "index_order_products_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "institution_id"
    t.date     "date_st"
    t.date     "date_fn"
    t.date     "date_sa"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "orders", ["institution_id"], name: "index_orders_on_institution_id"

  create_table "products", force: :cascade do |t|
    t.string   "code",       limit: 9
    t.string   "name",       limit: 50
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "products", ["code"], name: "index_products_on_code"

  create_table "receipt_products", force: :cascade do |t|
    t.integer  "receipt_id"
    t.integer  "product_id"
    t.decimal  "count_plan", precision: 8, scale: 2
    t.decimal  "count_fact", precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.date     "date"
  end

  add_index "receipt_products", ["product_id"], name: "index_receipt_products_on_product_id"
  add_index "receipt_products", ["receipt_id"], name: "index_receipt_products_on_receipt_id"

  create_table "receipts", force: :cascade do |t|
    t.integer  "institution_id"
    t.date     "date"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.date     "date_sa"
    t.integer  "supplier_order_id"
    t.string   "invoice_number",    limit: 12
    t.string   "contract_number",   limit: 12
  end

  add_index "receipts", ["institution_id"], name: "index_receipts_on_institution_id"
  add_index "receipts", ["supplier_order_id"], name: "index_receipts_on_supplier_order_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 15
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "so_products", force: :cascade do |t|
    t.integer  "supplier_order_id"
    t.integer  "institution_id"
    t.integer  "product_id"
    t.date     "date"
    t.decimal  "count",                        precision: 8, scale: 2
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "contract_number",   limit: 12
  end

  add_index "so_products", ["institution_id"], name: "index_so_products_on_institution_id"
  add_index "so_products", ["product_id"], name: "index_so_products_on_product_id"
  add_index "so_products", ["supplier_order_id"], name: "index_so_products_on_supplier_order_id"

  create_table "supplier_orders", force: :cascade do |t|
    t.integer  "branch_id"
    t.integer  "supplier_id"
    t.string   "number",      limit: 12
    t.date     "date"
    t.date     "date_st"
    t.date     "date_fn"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "supplier_orders", ["branch_id"], name: "index_supplier_orders_on_branch_id"
  add_index "supplier_orders", ["supplier_id"], name: "index_supplier_orders_on_supplier_id"

  create_table "suppliers", force: :cascade do |t|
    t.integer  "code",       limit: 4
    t.string   "name",       limit: 50
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "suppliers", ["code"], name: "index_suppliers_on_code"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.boolean  "is_admin"
    t.boolean  "is_supplier"
    t.integer  "institution_id"
    t.integer  "supplier_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["institution_id"], name: "index_users_on_institution_id"
  add_index "users", ["supplier_id"], name: "index_users_on_supplier_id"

end

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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110817031247) do

  create_table "customers", :force => true do |t|
    t.integer  "user_id"
    t.string   "company_name"
    t.string   "billing_street_address"
    t.string   "billing_city"
    t.string   "billing_state"
    t.string   "billing_zip_code"
    t.string   "shipping_street_address"
    t.string   "shipping_city"
    t.string   "shipping_state"
    t.string   "shipping_zip_code"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "email_address"
    t.string   "contact_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventories", :force => true do |t|
    t.integer  "product_id"
    t.string   "lot_no"
    t.date     "expiration_date"
    t.integer  "quantity_on_hand"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", :force => true do |t|
    t.string   "name"
    t.integer  "page_id"
    t.integer  "parent_id"
    t.boolean  "has_submenu"
    t.integer  "m_order"
    t.string   "m_type"
    t.text     "rawhtml"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "inventory_id"
    t.float    "price"
    t.integer  "quantity"
    t.boolean  "shipped"
    t.date     "shipped_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "customer_id"
    t.date     "date_shipped"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "in_menu"
    t.string   "menu_local"
  end

  create_table "pricings", :force => true do |t|
    t.integer  "product_id"
    t.float    "purchase_price"
    t.float    "competitor_price"
    t.float    "contract_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.integer  "vender_id"
    t.string   "name"
    t.text     "description"
    t.string   "ndc_no"
    t.string   "item_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rights", :force => true do |t|
    t.string "name"
    t.string "controller"
    t.string "action"
  end

  create_table "rights_roles", :id => false, :force => true do |t|
    t.integer "right_id"
    t.integer "role_id"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "shippings", :force => true do |t|
    t.integer  "packing_slip_no"
    t.date     "date_shipped"
    t.string   "shipped_via"
    t.integer  "weight"
    t.float    "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tiny_prints", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_file_size"
    t.string   "image_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tiny_videos", :force => true do |t|
    t.string   "original_file_name"
    t.string   "original_file_size"
    t.string   "original_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_attributes", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "handle"
    t.date     "birthdate"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                   :default => "passive"
    t.datetime "deleted_at"
    t.string   "password_reset_code",       :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", :force => true do |t|
    t.string   "company_name"
    t.string   "billing_street_address"
    t.string   "billing_city"
    t.string   "billing_state"
    t.string   "billing_zip_code"
    t.string   "shipping_street_address"
    t.string   "shipping_city"
    t.string   "shipping_state"
    t.string   "shipping_zip_code"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "email_address"
    t.string   "contact_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

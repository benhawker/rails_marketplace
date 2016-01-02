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

ActiveRecord::Schema.define(version: 20160102062157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "listing_id"
    t.string   "name"
  end

  add_index "categories", ["listing_id"], name: "index_categories_on_listing_id", using: :btree

  create_table "categories_listings", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "listing_id",  null: false
  end

  add_index "categories_listings", ["category_id", "listing_id"], name: "index_categories_listings_on_category_id_and_listing_id", using: :btree
  add_index "categories_listings", ["listing_id", "category_id"], name: "index_categories_listings_on_listing_id_and_category_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "rating"
    t.string   "comment"
    t.integer  "listing_id"
    t.integer  "user_id"
    t.integer  "seller_id"
    t.integer  "buyer_id"
    t.string   "direction",  default: "buyer_to_seller"
  end

  add_index "feedbacks", ["listing_id"], name: "index_feedbacks_on_listing_id", using: :btree
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "inquiries", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "inquiries", ["user_id"], name: "index_inquiries_on_user_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "title"
    t.string   "subtitle"
    t.string   "description"
    t.float    "price"
    t.string   "condition"
    t.string   "brand"
    t.string   "model"
    t.string   "case_type"
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "status",      default: "active"
    t.boolean  "featured",    default: false
    t.integer  "location_id"
  end

  add_index "listings", ["category_id"], name: "index_listings_on_category_id", using: :btree
  add_index "listings", ["location_id"], name: "index_listings_on_location_id", using: :btree
  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "full_address", limit: 255
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "inquiry_id"
    t.integer  "user_id"
    t.boolean  "read",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["inquiry_id"], name: "index_messages_on_inquiry_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "offers", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "listing_id"
    t.string   "price"
    t.integer  "user_id"
    t.string   "status",     default: "made"
  end

  add_index "offers", ["listing_id"], name: "index_offers_on_listing_id", using: :btree
  add_index "offers", ["user_id"], name: "index_offers_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "listing_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["listing_id"], name: "index_photos_on_listing_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "user_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "country"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "role",                   default: "standard"
    t.integer  "location_id"
    t.string   "house_number"
    t.string   "location"
    t.string   "street_address"
    t.string   "postal_code"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["location_id"], name: "index_users_on_location_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "watches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "listing_id"
    t.integer  "user_id"
  end

  add_index "watches", ["listing_id"], name: "index_watches_on_listing_id", using: :btree
  add_index "watches", ["user_id"], name: "index_watches_on_user_id", using: :btree

  add_foreign_key "categories", "listings"
  add_foreign_key "feedbacks", "listings"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "inquiries", "users"
  add_foreign_key "listings", "categories"
  add_foreign_key "listings", "locations"
  add_foreign_key "listings", "users"
  add_foreign_key "offers", "listings"
  add_foreign_key "offers", "users"
  add_foreign_key "photos", "listings"
  add_foreign_key "users", "locations"
  add_foreign_key "watches", "listings"
  add_foreign_key "watches", "users"
end

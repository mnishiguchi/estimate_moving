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

ActiveRecord::Schema.define(version: 20160805125855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "default_volumes", force: :cascade do |t|
    t.string   "name"
    t.float    "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "household_items", force: :cascade do |t|
    t.string   "name"
    t.integer  "volume"
    t.integer  "quantity"
    t.text     "description"
    t.integer  "moving_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["moving_id"], name: "index_household_items_on_moving_id", using: :btree
  end

  create_table "item_tags", force: :cascade do |t|
    t.integer  "household_item_id"
    t.integer  "tag_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["household_item_id"], name: "index_item_tags_on_household_item_id", using: :btree
    t.index ["tag_id"], name: "index_item_tags_on_tag_id", using: :btree
  end

  create_table "movings", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "unit",        default: 0
    t.index ["user_id"], name: "index_movings_on_user_id", using: :btree
  end

  create_table "social_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "email"
    t.string   "url"
    t.string   "image_url"
    t.string   "description"
    t.text     "others"
    t.text     "credentials"
    t.text     "raw_info"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["provider", "uid"], name: "index_social_profiles_on_provider_and_uid", unique: true, using: :btree
    t.index ["user_id"], name: "index_social_profiles_on_user_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "household_items", "movings"
  add_foreign_key "item_tags", "household_items"
  add_foreign_key "item_tags", "tags"
  add_foreign_key "movings", "users"
  add_foreign_key "social_profiles", "users"
end

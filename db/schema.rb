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

ActiveRecord::Schema.define(version: 20171125015438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calculators", force: :cascade do |t|
    t.integer  "calories"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", id: :bigserial, force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guides", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "hits"
    t.string   "user_name"
  end

  create_table "gyms", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  add_index "gyms", ["user_id"], name: "index_gyms_on_user_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "image_id"
    t.string   "image_filename"
    t.integer  "image_size"
    t.string   "image_content_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "triplaces", id: :bigserial, force: :cascade do |t|
    t.string   "title"
    t.decimal  "price"
    t.string   "photoURL"
    t.string   "description"
    t.integer  "city_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "userinfos", id: :bigserial, force: :cascade do |t|
    t.string   "realname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "type"
    t.boolean  "admin",           default: false
    t.float    "height"
    t.float    "weight"
    t.date     "date_of_birth"
    t.text     "description"
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "widgets", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

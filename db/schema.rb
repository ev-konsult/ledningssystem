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

ActiveRecord::Schema.define(version: 20160210142425) do

  create_table "articles", force: :cascade do |t|
    t.text     "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "contact_people", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "full_name"
    t.string   "phone_number"
    t.string   "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "contact_people", ["user_id"], name: "index_contact_people_on_user_id"

  create_table "educations", force: :cascade do |t|
    t.string   "name"
    t.string   "school"
    t.datetime "graduation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "educations", ["user_id"], name: "index_educations_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.string   "ssn"
    t.string   "phone_number"
    t.string   "email"
  end

end

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

ActiveRecord::Schema.define(version: 20160301115349) do

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

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.integer  "category"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "educations", force: :cascade do |t|
    t.string   "name"
    t.string   "school"
    t.datetime "graduation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "educations", ["user_id"], name: "index_educations_on_user_id"

  create_table "roles", force: :cascade do |t|
    t.string   "role_name"
    t.boolean  "can_edit_news",                   default: false
    t.boolean  "can_edit_staff",                  default: false
    t.boolean  "can_edit_tasks",                  default: false
    t.boolean  "can_edit_documents",              default: false
    t.boolean  "can_show_person_details_verbose", default: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.string   "title"
    t.text     "description"
    t.integer  "status",      default: 0
    t.integer  "priority",    default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "tasks_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "task_id"
  end

  add_index "tasks_users", ["task_id"], name: "index_tasks_users_on_task_id"
  add_index "tasks_users", ["user_id"], name: "index_tasks_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "remember_digest"
    t.string   "ssn"
    t.string   "phone_number"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.integer  "role_id"
  end

  add_index "users", ["role_id"], name: "index_users_on_role_id"

end

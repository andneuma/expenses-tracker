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

ActiveRecord::Schema.define(version: 20161026155453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "todo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["todo_id"], name: "index_comments_on_todo_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "expense_lists", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "budget_in_euro"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.text     "members",               default: [],                array: true
    t.boolean  "notifications_enabled", default: true
    t.decimal  "crit_threshold",        default: 0.15
  end

  create_table "expenses", force: :cascade do |t|
    t.string   "where"
    t.text     "comment"
    t.decimal  "expenses_in_euro"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "expense_list_id"
    t.integer  "user_id"
    t.string   "cash_desk"
    t.datetime "expense_date"
  end

  add_index "expenses", ["expense_list_id"], name: "index_expenses_on_expense_list_id", using: :btree
  add_index "expenses", ["user_id"], name: "index_expenses_on_user_id", using: :btree

  create_table "todo_lists", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "todos", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "starts_at"
    t.date     "ends_at"
    t.integer  "todo_list_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "finished",     default: false
  end

  add_index "todos", ["todo_list_id"], name: "index_todos_on_todo_list_id", using: :btree

  create_table "todos_users", id: false, force: :cascade do |t|
    t.integer "todo_id", null: false
    t.integer "user_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "is_admin",        default: false
  end

  add_foreign_key "comments", "todos"
  add_foreign_key "comments", "users"
  add_foreign_key "expenses", "expense_lists"
  add_foreign_key "expenses", "users"
  add_foreign_key "todos", "todo_lists"
end

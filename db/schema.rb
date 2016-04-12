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

ActiveRecord::Schema.define(version: 20160411154553) do

  create_table "expense_lists", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "budget_in_euro"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "expense_id"
  end

  add_index "expense_lists", ["expense_id"], name: "index_expense_lists_on_expense_id"

  create_table "expenses", force: :cascade do |t|
    t.string   "where"
    t.text     "comment"
    t.date     "when"
    t.decimal  "expenses_in_euro"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "expense_list_id"
  end

  add_index "expenses", ["expense_list_id"], name: "index_expenses_on_expense_list_id"

end
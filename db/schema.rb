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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120322003354) do

  create_table "tasks", :force => true do |t|
    t.string   "name",        :limit => 512,  :null => false
    t.string   "description", :limit => 1064
    t.date     "due_date"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "status"
  end

  create_table "user_tasks", :force => true do |t|
    t.integer  "tasks_id"
    t.integer  "users_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_tasks", ["tasks_id"], :name => "index_user_tasks_on_tasks_id"
  add_index "user_tasks", ["users_id", "tasks_id"], :name => "index_user_tasks_on_users_id_and_tasks_id", :unique => true
  add_index "user_tasks", ["users_id"], :name => "index_user_tasks_on_users_id"

  create_table "users", :force => true do |t|
    t.string   "first_name",           :limit => 128,                    :null => false
    t.string   "phone",                :limit => 15
    t.string   "email",                :limit => 128,                    :null => false
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.string   "encrypted_password"
    t.string   "last_name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "salt"
    t.boolean  "admin",                               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end

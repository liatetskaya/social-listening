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

ActiveRecord::Schema.define(:version => 20130331110552) do

  create_table "attributes", :force => true do |t|
    t.string   "fs_id"
    t.boolean  "fs_is_active"
    t.string   "tw_id"
    t.boolean  "tw_is_active"
    t.string   "keyword"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  create_table "checkins", :force => true do |t|
    t.string   "push_id"
    t.integer  "created_at",          :null => false
    t.string   "user_gender"
    t.string   "user_id"
    t.string   "user_first_name"
    t.string   "user_last_name"
    t.string   "user_photo"
    t.string   "venue_id"
    t.integer  "stat_checkins_count"
    t.string   "stat_users_count"
    t.text     "message"
    t.string   "notes"
    t.integer  "user_profile"
    t.datetime "updated_at",          :null => false
  end

  create_table "feeds", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "foursquare_users", :force => true do |t|
    t.string   "foursquare_id"
    t.string   "access_token"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "foursquare_users", ["foursquare_id"], :name => "index_foursquare_users_on_foursquare_id"

  create_table "registrations", :force => true do |t|
    t.string   "fs_id"
    t.boolean  "fs_is_active"
    t.string   "tw_id"
    t.boolean  "tw_is_active"
    t.string   "keyword"
    t.string   "longitude"
    t.string   "latitude"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

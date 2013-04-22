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

ActiveRecord::Schema.define(:version => 20130422041833) do

  create_table "checkins", :force => true do |t|
    t.string   "rm_service_id"
    t.string   "rm_merchant_id"
    t.string   "rm_user_id"
    t.string   "rm_created_at"
    t.string   "rm_message_id"
    t.string   "rm_message_url"
    t.string   "user_first_name"
    t.string   "user_last_name"
    t.string   "user_screen_name"
    t.string   "user_photo"
    t.string   "user_info"
    t.string   "post_text"
    t.string   "post_url"
    t.string   "picture"
    t.string   "location"
    t.string   "place_id"
    t.text     "notes"
    t.text     "message"
    t.string   "client_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "profile_id"
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

  create_table "insights", :force => true do |t|
    t.string   "Page"
    t.integer  "page_fan_adds"
    t.integer  "page_views"
    t.integer  "page_engaged_users"
    t.integer  "page_places_checkins"
    t.integer  "page_posts_impressions"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "profiles", :force => true do |t|
    t.string   "token"
    t.string   "address"
    t.boolean  "is_active"
    t.string   "status"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "user_id"
    t.string   "service"
    t.string   "service_id"
    t.string   "location"
    t.string   "keywords"
    t.string   "last_message_timestamp"
    t.string   "last_message_id"
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
    t.integer  "foursquare_user_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

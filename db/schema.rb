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

ActiveRecord::Schema.define(:version => 20121201151504) do

  create_table "answers", :force => true do |t|
    t.integer  "microhoop_id"
    t.integer  "user_id"
    t.text     "content"
    t.integer  "votes",        :default => 0, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "answers", ["microhoop_id", "created_at"], :name => "index_answers_on_microhoop_id_and_created_at"
  add_index "answers", ["user_id", "created_at"], :name => "index_answers_on_user_id_and_created_at"

  create_table "microhoops", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.text     "content",                       :null => false
    t.integer  "votes",      :default => 0,     :null => false
    t.string   "location",                      :null => false
    t.boolean  "is_meeting", :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "microhoops", ["user_id", "created_at"], :name => "index_microhoops_on_user_id_and_created_at"

  create_table "microhoops_tags_relationships", :force => true do |t|
    t.integer  "microhoop_id"
    t.integer  "tag_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "microhoops_tags_relationships", ["microhoop_id", "tag_id"], :name => "index_microhoops_tags_relationships_on_microhoop_id_and_tag_id", :unique => true
  add_index "microhoops_tags_relationships", ["microhoop_id"], :name => "index_microhoops_tags_relationships_on_microhoop_id"
  add_index "microhoops_tags_relationships", ["tag_id"], :name => "index_microhoops_tags_relationships_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "university"
    t.integer  "points",       :default => 0, :null => false
    t.string   "device_token"
    t.string   "fb_uuid"
    t.string   "fb_token"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "users_tags_relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users_tags_relationships", ["tag_id"], :name => "index_users_tags_relationships_on_tag_id"
  add_index "users_tags_relationships", ["user_id", "tag_id"], :name => "index_users_tags_relationships_on_user_id_and_tag_id", :unique => true
  add_index "users_tags_relationships", ["user_id"], :name => "index_users_tags_relationships_on_user_id"

end

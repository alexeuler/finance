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

ActiveRecord::Schema.define(version: 20141216072651) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blog_posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.text     "tags"
    t.string   "status"
    t.string   "category"
    t.text     "excerpt"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language",       default: "ru", null: false
    t.integer  "video_group_id"
    t.string   "breed"
  end

  create_table "blog_tags", force: true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language",   default: "ru", null: false
  end

  create_table "image_tags", force: true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "tags"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "video_groups", force: true do |t|
    t.string   "value"
    t.string   "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language"
    t.integer  "order"
  end

end

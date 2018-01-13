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

ActiveRecord::Schema.define(version: 20180113125924) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chunked_upload_tasks", force: :cascade do |t|
    t.integer "file_size", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "file_chunks", force: :cascade do |t|
    t.bigint "chunked_upload_task_id", null: false
    t.string "data_file_name", null: false
    t.string "data_content_type", null: false
    t.integer "data_file_size", null: false
    t.datetime "data_updated_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chunked_upload_task_id"], name: "index_file_chunks_on_chunked_upload_task_id"
  end

  create_table "large_files", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type", null: false
    t.integer "data_file_size", null: false
    t.datetime "data_updated_at", null: false
    t.bigint "chunked_upload_task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chunked_upload_task_id"], name: "index_large_files_on_chunked_upload_task_id"
  end

  add_foreign_key "file_chunks", "chunked_upload_tasks"
  add_foreign_key "large_files", "chunked_upload_tasks"
end

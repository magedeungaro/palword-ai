# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_14_001358) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_messages", force: :cascade do |t|
    t.string "role"
    t.bigint "chat_id", null: false
    t.text "content"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_chat_messages_on_chat_id"
    t.index ["role"], name: "index_chat_messages_on_role"
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "elements", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pal_elements", force: :cascade do |t|
    t.bigint "pal_id", null: false
    t.bigint "element_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["element_id"], name: "index_pal_elements_on_element_id"
    t.index ["pal_id"], name: "index_pal_elements_on_pal_id"
  end

  create_table "pal_work_suitabilities", force: :cascade do |t|
    t.integer "level"
    t.bigint "pal_id", null: false
    t.bigint "work_suitability_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pal_id"], name: "index_pal_work_suitabilities_on_pal_id"
    t.index ["work_suitability_id"], name: "index_pal_work_suitabilities_on_work_suitability_id"
  end

  create_table "pals", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_suitabilities", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "chat_messages", "chats"
  add_foreign_key "chats", "users"
  add_foreign_key "pal_elements", "elements"
  add_foreign_key "pal_elements", "pals"
  add_foreign_key "pal_work_suitabilities", "pals"
  add_foreign_key "pal_work_suitabilities", "work_suitabilities"
end

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

ActiveRecord::Schema.define(version: 2019_01_07_184749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adm_view_data", force: :cascade do |t|
    t.string "id_user"
    t.string "view_list_adm_iframe_1"
    t.string "view_location"
    t.string "view_location_iframe"
    t.string "view_user_adm_iframe_id_1"
    t.string "view_list_game_iframe_1"
    t.string "view_list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "id_user"
    t.string "name_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.string "hp"
    t.string "money"
  end

  create_table "quests", force: :cascade do |t|
    t.string "id_user"
    t.string "stage"
    t.string "id_quest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_quest"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "adm"
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end

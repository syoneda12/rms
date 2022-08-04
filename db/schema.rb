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

ActiveRecord::Schema.define(version: 2021_06_01_102646) do

  create_table "authorities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leader_user_links", force: :cascade do |t|
    t.integer "leader_id"
    t.integer "subordinate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_authority_links", force: :cascade do |t|
    t.integer "role_id"
    t.integer "authority_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authority_id"], name: "index_role_authority_links_on_authority_id"
    t.index ["role_id"], name: "index_role_authority_links_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skill_kinds", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skill_levels", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "name", null: false
    t.integer "skill_kind_id"
    t.index ["skill_kind_id"], name: "index_skills_on_skill_kind_id"
  end

  create_table "user_skill_links", force: :cascade do |t|
    t.integer "user_id"
    t.integer "skill_id"
    t.integer "skill_level_id"
    t.integer "hide", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_user_skill_links_on_skill_id"
    t.index ["skill_level_id"], name: "index_user_skill_links_on_skill_level_id"
    t.index ["user_id"], name: "index_user_skill_links_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "role_id", default: 0, null: false
    t.integer "gender", default: 0, null: false
    t.date "birthday"
    t.string "address"
    t.string "closest_station"
    t.boolean "profile_hide", default: false, null: false
    t.integer "years_of_experience"
    t.integer "department_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

end

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

ActiveRecord::Schema[7.0].define(version: 2023_06_09_123237) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string "slack_id"
    t.string "auth_user_id"
    t.string "scope"
    t.string "access_token"
    t.string "team_id"
    t.string "team_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "channels", force: :cascade do |t|
    t.string "slack_id"
    t.string "name"
    t.string "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "incident_id"
    t.index ["incident_id"], name: "index_channels_on_incident_id"
  end

  create_table "incidents", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "severity"
    t.integer "status", default: 0
    t.string "webhook_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "reporter_id"
    t.bigint "resolver_id"
    t.bigint "app_id"
    t.index ["app_id"], name: "index_incidents_on_app_id"
    t.index ["reporter_id"], name: "index_incidents_on_reporter_id"
    t.index ["resolver_id"], name: "index_incidents_on_resolver_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "slack_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "channels", "incidents"
  add_foreign_key "incidents", "users", column: "reporter_id"
  add_foreign_key "incidents", "users", column: "resolver_id"
end

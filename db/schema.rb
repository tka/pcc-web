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

ActiveRecord::Schema.define(version: 20130113040758) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "procurements", force: true do |t|
    t.integer  "procuring_entity_id"
    t.string   "job_number"
    t.string   "subject"
    t.integer  "price",               limit: 8
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "finish_at"
  end

  add_index "procurements", ["finish_at"], name: "index_procurements_on_finish_at", using: :btree
  add_index "procurements", ["procuring_entity_id"], name: "index_procurements_on_procuring_entity_id", using: :btree

  create_table "procuring_entities", force: true do |t|
    t.string   "entity_code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tender_infos", force: true do |t|
    t.integer  "procurement_id"
    t.integer  "tenderer_id"
    t.integer  "price",          limit: 8
    t.boolean  "winning",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tender_infos", ["procurement_id"], name: "index_tender_infos_on_procurement_id", using: :btree
  add_index "tender_infos", ["tenderer_id"], name: "index_tender_infos_on_tenderer_id", using: :btree

  create_table "tenderers", force: true do |t|
    t.string   "business_number"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tender_infos_count"
    t.integer  "winning_tender_infos_count"
  end

  add_index "tenderers", ["name"], name: "index_tenderers_on_name", using: :btree
  add_index "tenderers", ["tender_infos_count"], name: "index_tenderers_on_tender_infos_count", using: :btree
  add_index "tenderers", ["winning_tender_infos_count"], name: "index_tenderers_on_winning_tender_infos_count", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

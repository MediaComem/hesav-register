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

ActiveRecord::Schema.define(version: 20140729065711) do

  create_table "events", force: true do |t|
    t.string   "short_name"
    t.string   "name"
    t.string   "description"
    t.date     "open"
    t.date     "close"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gouveole_registrations", force: true do |t|
    t.boolean  "male"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "affiliation"
    t.string   "affiliation_address"
    t.string   "job"
    t.string   "email"
    t.string   "phone"
    t.string   "billing_address"
    t.string   "city"
    t.string   "knowledge"
    t.string   "expectations"
    t.string   "activities"
    t.string   "remarks"
    t.string   "shopID"
    t.string   "environment"
    t.string   "language"
    t.integer  "price"
    t.boolean  "paid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

end

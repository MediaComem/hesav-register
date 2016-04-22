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

ActiveRecord::Schema.define(version: 20160422074926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "death14_registrations", force: true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "street"
    t.integer  "npa"
    t.string   "city"
    t.string   "email"
    t.string   "shopID"
    t.string   "environment"
    t.string   "language"
    t.string   "job"
    t.string   "employer"
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
    t.string   "country"
    t.string   "workshop"
  end

  create_table "etu14_registrations", force: true do |t|
    t.string   "title"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "street"
    t.integer  "npa"
    t.string   "city"
    t.string   "country"
    t.string   "employer"
    t.string   "job"
    t.string   "email"
    t.integer  "price"
    t.integer  "registration_type"
    t.boolean  "assistance"
    t.boolean  "payed"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "title"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "affiliation"
    t.string   "affiliation_address"
    t.string   "job"
    t.string   "email"
    t.string   "phone"
    t.boolean  "theorical_knowledge"
    t.boolean  "practical_p_knowledge"
    t.boolean  "practical_o_knowledge"
    t.boolean  "no_knowledge"
    t.string   "expectations"
    t.string   "activities"
    t.string   "remarks"
    t.integer  "price"
    t.boolean  "paid"
    t.boolean  "rules_accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.boolean  "certified_infos"
    t.boolean  "accept_conditions"
  end

  create_table "nursing15_registrations", force: true do |t|
    t.string   "title"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "street"
    t.integer  "npa"
    t.string   "city"
    t.string   "country"
    t.string   "email"
    t.string   "shopID"
    t.string   "environment"
    t.string   "language"
    t.string   "job"
    t.string   "employer"
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
  end

  create_table "psy14_registrations", force: true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "street"
    t.integer  "npa"
    t.string   "city"
    t.string   "email"
    t.string   "shopID"
    t.string   "environment"
    t.string   "language"
    t.string   "job"
    t.string   "employer"
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
  end

  create_table "psy16_registrations", force: true do |t|
    t.string   "title"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "street"
    t.integer  "npa"
    t.string   "city"
    t.string   "country"
    t.string   "email"
    t.string   "shopID"
    t.string   "environment"
    t.string   "language"
    t.string   "job"
    t.string   "employer"
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
  end

end

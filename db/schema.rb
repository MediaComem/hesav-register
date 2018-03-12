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

ActiveRecord::Schema.define(version: 20180312125530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "auto17_registrations", force: :cascade do |t|
    t.string   "last_name",         limit: 255
    t.string   "first_name",        limit: 255
    t.string   "street",            limit: 255
    t.integer  "npa"
    t.string   "city",              limit: 255
    t.string   "email",             limit: 255
    t.string   "employer",          limit: 255
    t.string   "job",               limit: 255
    t.string   "shopID",            limit: 255
    t.string   "environment",       limit: 255
    t.string   "language",          limit: 255
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
    t.boolean  "food"
    t.boolean  "translate"
    t.integer  "streetnumber"
  end

  create_table "death14_registrations", force: :cascade do |t|
    t.string   "last_name",         limit: 255
    t.string   "first_name",        limit: 255
    t.string   "street",            limit: 255
    t.integer  "npa"
    t.string   "city",              limit: 255
    t.string   "email",             limit: 255
    t.string   "shopID",            limit: 255
    t.string   "environment",       limit: 255
    t.string   "language",          limit: 255
    t.string   "job",               limit: 255
    t.string   "employer",          limit: 255
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
    t.string   "country",           limit: 255
    t.string   "workshop",          limit: 255
  end

  create_table "etu14_registrations", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "last_name",         limit: 255
    t.string   "first_name",        limit: 255
    t.string   "street",            limit: 255
    t.integer  "npa"
    t.string   "city",              limit: 255
    t.string   "country",           limit: 255
    t.string   "employer",          limit: 255
    t.string   "job",               limit: 255
    t.string   "email",             limit: 255
    t.integer  "price"
    t.integer  "registration_type"
    t.boolean  "assistance"
    t.boolean  "payed"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "short_name",  limit: 255
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.date     "open"
    t.date     "close"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gouveole_registrations", force: :cascade do |t|
    t.string   "title",                 limit: 255
    t.string   "last_name",             limit: 255
    t.string   "first_name",            limit: 255
    t.string   "affiliation",           limit: 255
    t.string   "affiliation_address",   limit: 255
    t.string   "job",                   limit: 255
    t.string   "email",                 limit: 255
    t.string   "phone",                 limit: 255
    t.boolean  "theorical_knowledge"
    t.boolean  "practical_p_knowledge"
    t.boolean  "practical_o_knowledge"
    t.boolean  "no_knowledge"
    t.string   "expectations",          limit: 255
    t.string   "activities",            limit: 255
    t.string   "remarks",               limit: 255
    t.integer  "price"
    t.boolean  "paid"
    t.boolean  "rules_accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.boolean  "certified_infos"
    t.boolean  "accept_conditions"
  end

  create_table "jpsy16_registrations", force: :cascade do |t|
    t.string   "last_name",         limit: 255
    t.string   "first_name",        limit: 255
    t.string   "street",            limit: 255
    t.integer  "npa"
    t.string   "city",              limit: 255
    t.string   "email",             limit: 255
    t.string   "employer",          limit: 255
    t.string   "shopID",            limit: 255
    t.string   "environment",       limit: 255
    t.string   "language",          limit: 255
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
  end

  create_table "jpsy18_registrations", force: :cascade do |t|
    t.string   "last_name",         limit: 255
    t.string   "first_name",        limit: 255
    t.string   "street",            limit: 255
    t.integer  "npa"
    t.string   "city",              limit: 255
    t.string   "email",             limit: 255
    t.string   "employer",          limit: 255
    t.string   "shopID",            limit: 255
    t.string   "environment",       limit: 255
    t.string   "language",          limit: 255
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
  end

  create_table "js16_registrations", force: :cascade do |t|
    t.string   "last_name",         limit: 255
    t.string   "first_name",        limit: 255
    t.string   "street",            limit: 255
    t.integer  "npa"
    t.string   "city",              limit: 255
    t.string   "email",             limit: 255
    t.string   "employer",          limit: 255
    t.string   "shopID",            limit: 255
    t.string   "environment",       limit: 255
    t.string   "language",          limit: 255
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
  end

  create_table "js17_registrations", force: :cascade do |t|
    t.string   "last_name",         limit: 255
    t.string   "first_name",        limit: 255
    t.string   "street",            limit: 255
    t.integer  "streetnumber"
    t.integer  "npa"
    t.string   "city",              limit: 255
    t.string   "email",             limit: 255
    t.string   "employer",          limit: 255
    t.string   "job",               limit: 255
    t.string   "shopID",            limit: 255
    t.string   "environment",       limit: 255
    t.string   "language",          limit: 255
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_id",          limit: 255
    t.hstore   "registration_type"
    t.hstore   "ateliers"
  end

  create_table "nursing15_registrations", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "last_name",         limit: 255
    t.string   "first_name",        limit: 255
    t.string   "street",            limit: 255
    t.integer  "npa"
    t.string   "city",              limit: 255
    t.string   "country",           limit: 255
    t.string   "email",             limit: 255
    t.string   "shopID",            limit: 255
    t.string   "environment",       limit: 255
    t.string   "language",          limit: 255
    t.string   "job",               limit: 255
    t.string   "employer",          limit: 255
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
  end

  create_table "psy14_registrations", force: :cascade do |t|
    t.string   "last_name",         limit: 255
    t.string   "first_name",        limit: 255
    t.string   "street",            limit: 255
    t.integer  "npa"
    t.string   "city",              limit: 255
    t.string   "email",             limit: 255
    t.string   "shopID",            limit: 255
    t.string   "environment",       limit: 255
    t.string   "language",          limit: 255
    t.string   "job",               limit: 255
    t.string   "employer",          limit: 255
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
  end

  create_table "psy16_registrations", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "last_name",         limit: 255
    t.string   "first_name",        limit: 255
    t.string   "street",            limit: 255
    t.integer  "npa"
    t.string   "city",              limit: 255
    t.string   "country",           limit: 255
    t.string   "email",             limit: 255
    t.string   "shopID",            limit: 255
    t.string   "environment",       limit: 255
    t.string   "language",          limit: 255
    t.string   "job",               limit: 255
    t.string   "employer",          limit: 255
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
  end

  create_table "psy17_registrations", force: :cascade do |t|
    t.string   "last_name",         limit: 255
    t.string   "first_name",        limit: 255
    t.string   "street",            limit: 255
    t.integer  "streetnumber"
    t.integer  "npa"
    t.string   "city",              limit: 255
    t.string   "email",             limit: 255
    t.string   "employer",          limit: 255
    t.string   "job",               limit: 255
    t.string   "shopID",            limit: 255
    t.string   "environment",       limit: 255
    t.string   "language",          limit: 255
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_id",          limit: 255
    t.hstore   "registration_type"
    t.hstore   "ateliers"
  end

  create_table "symposium18_registrations", force: :cascade do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "street"
    t.integer  "npa"
    t.string   "city"
    t.string   "email"
    t.string   "employer"
    t.string   "shopID"
    t.string   "environment"
    t.string   "language"
    t.boolean  "payed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.hstore   "registration_type"
  end

  create_table "trm30_registrations", force: :cascade do |t|
    t.string   "last_name",    limit: 255
    t.string   "first_name",   limit: 255
    t.string   "street",       limit: 255
    t.string   "streetnumber", limit: 255
    t.integer  "npa"
    t.string   "city",         limit: 255
    t.string   "email",        limit: 255
    t.string   "employer",     limit: 255
    t.string   "environment",  limit: 255
    t.string   "language",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.string   "team",         limit: 255
  end

end

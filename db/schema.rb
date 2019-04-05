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

ActiveRecord::Schema.define(version: 2019_04_05_041909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drawings", force: :cascade do |t|
    t.text "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "subject"
  end

  create_table "equations", force: :cascade do |t|
    t.text "equation"
    t.boolean "veracity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operational_questions", force: :cascade do |t|
    t.bigint "operational_survey_id"
    t.integer "memory"
    t.boolean "veracity"
    t.integer "recall"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "equation_id"
    t.index ["equation_id"], name: "index_operational_questions_on_equation_id"
    t.index ["operational_survey_id"], name: "index_operational_questions_on_operational_survey_id"
  end

  create_table "operational_surveys", force: :cascade do |t|
    t.bigint "survey_id"
    t.integer "span", default: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_operational_surveys_on_survey_id"
  end

  create_table "reading_questions", force: :cascade do |t|
    t.bigint "reading_survey_id"
    t.integer "memory"
    t.integer "recall"
    t.boolean "veracity"
    t.bigint "sentence_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reading_survey_id"], name: "index_reading_questions_on_reading_survey_id"
    t.index ["sentence_id"], name: "index_reading_questions_on_sentence_id"
  end

  create_table "reading_surveys", force: :cascade do |t|
    t.bigint "survey_id"
    t.integer "span"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_reading_surveys_on_survey_id"
  end

  create_table "sentences", force: :cascade do |t|
    t.text "sentence"
    t.boolean "veracity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.integer "delay"
    t.integer "maximum_value"
    t.integer "minimum_value"
    t.integer "surveys"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.integer "subject"
    t.boolean "initial_instructions", default: true
    t.boolean "operational_instructions", default: true
    t.boolean "reading_instructions", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "operational_questions", "equations"
  add_foreign_key "operational_questions", "operational_surveys"
  add_foreign_key "operational_surveys", "surveys"
  add_foreign_key "reading_questions", "reading_surveys"
  add_foreign_key "reading_questions", "sentences"
  add_foreign_key "reading_surveys", "surveys"
end

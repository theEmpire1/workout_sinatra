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

ActiveRecord::Schema.define(version: 20151114203906) do

  create_table "exercises", force: :cascade do |t|
    t.string "name",        limit: 255
    t.string "description", limit: 255
  end

  create_table "workouts", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.string  "description", limit: 255
    t.integer "rating",      limit: 4
    t.integer "upvotes",     limit: 4
    t.integer "downvotes",   limit: 4
    t.integer "user_id",     limit: 4
  end

  create_table "workouts_exercises", force: :cascade do |t|
    t.integer "workouts_id",  limit: 4
    t.integer "exercises_id", limit: 4
  end

  add_index "workouts_exercises", ["exercises_id"], name: "index_workouts_exercises_on_exercises_id", using: :btree
  add_index "workouts_exercises", ["workouts_id"], name: "index_workouts_exercises_on_workouts_id", using: :btree

end

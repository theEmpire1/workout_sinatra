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

ActiveRecord::Schema.define(version: 20151121221254) do

  create_table "exercises", force: :cascade do |t|
    t.string "name",        limit: 255
    t.string "description", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string "name",            limit: 255
    t.string "email",           limit: 255
    t.string "password_digest", limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "workout_exercises", force: :cascade do |t|
    t.integer "workout_id",  limit: 4
    t.integer "exercise_id", limit: 4
  end

  add_index "workout_exercises", ["exercise_id"], name: "index_workout_exercises_on_exercise_id", using: :btree
  add_index "workout_exercises", ["workout_id"], name: "index_workout_exercises_on_workout_id", using: :btree

  create_table "workouts", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.string  "description", limit: 255
    t.integer "rating",      limit: 4
    t.integer "upvotes",     limit: 4
    t.integer "downvotes",   limit: 4
    t.integer "user_id",     limit: 4
  end

  add_index "workouts", ["user_id"], name: "index_workouts_on_user_id", using: :btree

end

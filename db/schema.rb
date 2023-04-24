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

ActiveRecord::Schema.define(version: 2023_04_19_200536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "specialty_id", null: false
    t.bigint "patient_id", null: false
    t.bigint "doctor_id", null: false
    t.datetime "appointment_datetime", null: false
    t.text "description"
    t.bigint "cabinet_id"
    t.text "before_visit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "datetime_slot_id", null: false
    t.index ["cabinet_id"], name: "index_appointments_on_cabinet_id"
    t.index ["datetime_slot_id"], name: "index_appointments_on_datetime_slot_id"
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["specialty_id"], name: "index_appointments_on_specialty_id"
  end

  create_table "cabinets", force: :cascade do |t|
    t.string "name", null: false
    t.integer "floor", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "datetime_slots", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.datetime "slot_datetime", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_datetime_slots_on_doctor_id"
  end

  create_table "specialties", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_specialties_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "telephone"
    t.integer "role", default: 0
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "jti", null: false
    t.bigint "specialty_id"
    t.bigint "cabinet_id"
    t.index ["cabinet_id"], name: "index_users_on_cabinet_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["specialty_id"], name: "index_users_on_specialty_id"
  end

  add_foreign_key "appointments", "cabinets"
  add_foreign_key "appointments", "datetime_slots"
  add_foreign_key "appointments", "specialties"
  add_foreign_key "appointments", "users", column: "doctor_id"
  add_foreign_key "appointments", "users", column: "patient_id"
  add_foreign_key "datetime_slots", "users", column: "doctor_id"
end

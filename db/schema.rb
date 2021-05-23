# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_23_061211) do

  create_table "area_positions", force: :cascade do |t|
    t.integer "x"
    t.integer "y"
    t.integer "face"
    t.boolean "initial"
    t.integer "u_robot_id"
    t.integer "area_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_id"], name: "index_area_positions_on_area_id"
    t.index ["u_robot_id"], name: "index_area_positions_on_u_robot_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.integer "x_min"
    t.integer "x_max"
    t.integer "y_min"
    t.integer "y_max"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "movements", force: :cascade do |t|
    t.integer "step"
    t.integer "u_robot_id"
    t.integer "area_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_id"], name: "index_movements_on_area_id"
    t.index ["u_robot_id"], name: "index_movements_on_u_robot_id"
  end

  create_table "u_robots", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end

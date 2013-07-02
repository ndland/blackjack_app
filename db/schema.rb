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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130702182133) do

  create_table "cards", :force => true do |t|
    t.string   "suit"
    t.string   "faceValue"
    t.boolean  "cardUsed"
    t.integer  "order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dealer_cards", :force => true do |t|
    t.string   "faceValue"
    t.string   "suit"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "game_lists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "table_id"
    t.integer  "bet_amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.integer  "credits"
    t.integer  "level"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "player_cards", :force => true do |t|
    t.string   "suit"
    t.string   "faceValue"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "game_id"
  end

  create_table "sleeves", :force => true do |t|
    t.string   "faceValue"
    t.string   "suit"
    t.boolean  "cardUsed"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tables", :force => true do |t|
    t.string   "name"
    t.integer  "min"
    t.integer  "max"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "winners", :force => true do |t|
    t.integer  "game_id"
    t.string   "outcome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

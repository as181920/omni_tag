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

ActiveRecord::Schema.define(version: 2018_05_17_095314) do

  create_table "omni_tag_taggings", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "context"
    t.datetime "created_at", null: false
    t.index ["tag_id", "taggable_id", "taggable_type", "context"], name: "index_omni_tag_taggings_on_tag_and_taggable_and_context", unique: true
    t.index ["tag_id"], name: "index_omni_tag_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_omni_tag_taggings_on_taggable_type_and_taggable_id"
  end

  create_table "omni_tag_tags", force: :cascade do |t|
    t.string "name", null: false
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_omni_tag_tags_on_name", unique: true
  end

end

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

ActiveRecord::Schema.define(version: 20200123065158) do

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sender_id"
    t.integer  "property_id"
    t.text     "comment",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "receiver_id"
    t.index ["created_at"], name: "index_comments_on_created_at", using: :btree
    t.index ["property_id", "sender_id", "receiver_id"], name: "test1", using: :btree
    t.index ["property_id"], name: "index_comments_on_property_id", using: :btree
    t.index ["sender_id", "property_id"], name: "test", using: :btree
  end

  create_table "interested_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["property_id", "user_id"], name: "index_interested_users_on_property_id_and_user_id", using: :btree
    t.index ["user_id"], name: "index_interested_users_on_user_id", using: :btree
  end

  create_table "properties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "owner_id"
    t.string   "property_type"
    t.string   "availability"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "tenant_id"
    t.integer  "rent"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["id"], name: "index_properties_on_id", using: :btree
    t.index ["owner_id", "availability", "id"], name: "index_properties_on_owner_id_and_availability_and_id", using: :btree
    t.index ["owner_id"], name: "index_properties_on_owner_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email_id"
    t.string   "password_hash"
    t.string   "user_name"
    t.bigint   "contact_no"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["email_id"], name: "index_users_on_email_id", using: :btree
    t.index ["id"], name: "index_users_on_id", using: :btree
  end

end

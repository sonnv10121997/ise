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

ActiveRecord::Schema.define(version: 2019_05_04_153710) do

  create_table "ckeditor_assets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "conversations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_conversations_on_receiver_id"
    t.index ["sender_id"], name: "index_conversations_on_sender_id"
  end

  create_table "event_majors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "major_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_majors_on_event_id"
    t.index ["major_id"], name: "index_event_majors_on_major_id"
  end

  create_table "event_requirements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "requirement_id", null: false
    t.date "deadline", null: false
    t.string "description"
    t.index ["event_id"], name: "index_event_requirements_on_event_id"
    t.index ["requirement_id"], name: "index_event_requirements_on_requirement_id"
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.bigint "leader_id", null: false
    t.integer "status", default: 0
    t.float "price", null: false
    t.integer "max_participants", null: false
    t.integer "joined_participants", default: 0
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "semester", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "partner_id", null: false
    t.string "slug", null: false
    t.index ["leader_id"], name: "index_events_on_leader_id"
    t.index ["partner_id"], name: "index_events_on_partner_id"
    t.index ["slug"], name: "index_events_on_slug", unique: true
  end

  create_table "friendly_id_slugs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, length: { slug: 70, scope: 70 }
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", length: { slug: 140 }
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "grade_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "transcript_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transcript_id"], name: "index_grade_categories_on_transcript_id"
  end

  create_table "grades", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.float "weight", null: false
    t.float "value"
    t.bigint "grade_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_category_id"], name: "index_grades_on_grade_category_id"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "imageable_type", null: false
    t.bigint "imageable_id", null: false
    t.string "file", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "majors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "acronym", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "conversation_id", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "mmos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "partner_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_mmos_on_partner_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "type", null: false
    t.bigint "event_id"
    t.bigint "receiver_id", null: false
    t.bigint "notifier_id", null: false
    t.bigint "requirement_id"
    t.bigint "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_notifications_on_event_id"
    t.index ["message_id"], name: "index_notifications_on_message_id"
    t.index ["notifier_id"], name: "index_notifications_on_notifier_id"
    t.index ["receiver_id"], name: "index_notifications_on_receiver_id"
    t.index ["requirement_id"], name: "index_notifications_on_requirement_id"
  end

  create_table "partners", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "country", null: false
    t.boolean "signed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", null: false
    t.index ["slug"], name: "index_partners_on_slug", unique: true
  end

  create_table "requirements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", null: false
    t.index ["slug"], name: "index_requirements_on_slug", unique: true
  end

  create_table "transcripts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "total"
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_transcripts_on_event_id"
    t.index ["user_id"], name: "index_transcripts_on_user_id"
  end

  create_table "user_enroll_events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_user_enroll_events_on_event_id"
    t.index ["user_id"], name: "index_user_enroll_events_on_user_id"
  end

  create_table "user_event_requirements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_requirement_id", null: false
    t.index ["event_requirement_id"], name: "index_user_event_requirements_on_event_requirement_id"
    t.index ["user_id"], name: "index_user_event_requirements_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "gender", null: false
    t.date "dob", null: false
    t.string "code", null: false
    t.string "phone", null: false
    t.string "type", default: "Student"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.bigint "major_id"
    t.string "slug", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["major_id"], name: "index_users_on_major_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "conversations", "users", column: "receiver_id"
  add_foreign_key "conversations", "users", column: "sender_id"
  add_foreign_key "event_majors", "events"
  add_foreign_key "event_majors", "majors"
  add_foreign_key "event_requirements", "events"
  add_foreign_key "event_requirements", "requirements"
  add_foreign_key "events", "partners"
  add_foreign_key "events", "users", column: "leader_id"
  add_foreign_key "grade_categories", "transcripts"
  add_foreign_key "grades", "grade_categories"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "mmos", "partners"
  add_foreign_key "notifications", "events"
  add_foreign_key "notifications", "messages"
  add_foreign_key "notifications", "requirements"
  add_foreign_key "notifications", "users", column: "notifier_id"
  add_foreign_key "notifications", "users", column: "receiver_id"
  add_foreign_key "transcripts", "events"
  add_foreign_key "transcripts", "users"
  add_foreign_key "user_enroll_events", "events"
  add_foreign_key "user_enroll_events", "users"
  add_foreign_key "user_event_requirements", "event_requirements"
  add_foreign_key "user_event_requirements", "users"
  add_foreign_key "users", "majors"
end

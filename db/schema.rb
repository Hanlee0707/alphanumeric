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

ActiveRecord::Schema.define(:version => 20130422134321) do

  create_table "additional_texts", :force => true do |t|
    t.integer  "article_id"
    t.text     "bullet"
    t.integer  "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "city"
    t.string   "country"
    t.text     "previous_summary"
    t.text     "current_content"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "status"
    t.integer  "contributor_id"
    t.integer  "editor_id"
    t.string   "temporary_title"
    t.text     "instruction"
    t.string   "category"
    t.datetime "published_at"
  end

  add_index "articles", ["contributor_id"], :name => "index_articles_on_contributor_id"
  add_index "articles", ["editor_id"], :name => "index_articles_on_editor_id"

  create_table "citations", :force => true do |t|
    t.integer  "article_id"
    t.string   "author"
    t.string   "title"
    t.date     "published_date"
    t.string   "publisher"
    t.string   "link"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.date     "accessed_date"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "employee_position_types", :force => true do |t|
    t.string   "position_type"
    t.integer  "number_of_levels"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "employee_positions", :force => true do |t|
    t.integer  "employee_id"
    t.string   "position"
    t.integer  "level"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "employee_positions", ["employee_id"], :name => "index_employee_positions_on_employee_id"
  add_index "employee_positions", ["position"], :name => "index_employee_positions_on_position"

  create_table "employees", :force => true do |t|
    t.string   "first_name"
    t.string   "email"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "password_digest"
    t.string   "last_name"
    t.string   "create_account_token"
    t.datetime "create_account_sent_at"
    t.datetime "account_create_time"
    t.datetime "latest_login_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "employees", ["last_name"], :name => "index_employees_on_last_name"

  create_table "extra_informations", :force => true do |t|
    t.integer  "article_id"
    t.string   "phrase"
    t.text     "explanation"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "article_id"
    t.string   "image_name"
    t.string   "image_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "location"
  end

  create_table "numbers", :force => true do |t|
    t.integer  "article_id"
    t.string   "value"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "explanation"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_archived_articles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_archived_articles", ["article_id"], :name => "index_user_archived_articles_on_article_id"
  add_index "user_archived_articles", ["user_id"], :name => "index_user_archived_articles_on_user_id"

  create_table "user_followed_articles", :force => true do |t|
    t.integer  "article_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_followed_articles", ["article_id"], :name => "index_user_followed_articles_on_article_id"
  add_index "user_followed_articles", ["user_id"], :name => "index_user_followed_articles_on_user_id"

  create_table "user_read_articles", :force => true do |t|
    t.integer  "article_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_read_articles", ["article_id"], :name => "index_user_read_articles_on_article_id"
  add_index "user_read_articles", ["user_id"], :name => "index_user_read_articles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "create_account_token"
    t.datetime "create_account_sent_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.datetime "latest_login_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"

end

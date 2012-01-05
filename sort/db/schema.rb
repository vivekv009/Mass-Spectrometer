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

ActiveRecord::Schema.define(:version => 20120326140333) do

  create_table "database_versions", :force => true do |t|
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "database_title"
    t.integer  "database_id"
    t.boolean  "enabled",        :default => true
    t.boolean  "processed",      :default => false
    t.string   "error_message"
  end

  create_table "databases", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "database_location"
    t.integer  "user_id"
    t.string   "title"
    t.boolean  "enabled",           :default => true
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "enzymes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "external_id"
  end

  create_table "ions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "external_id"
  end

  create_table "mass_search_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "protein_mods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "external_id"
  end

  create_table "submission_protein_mods", :force => true do |t|
    t.integer  "submission_id"
    t.integer  "protein_mod_id"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submissions", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",                     :limit => 1,   :default => "w"
    t.integer  "max_missed_cleavages",                      :default => 1
    t.integer  "hitlist_max_length",                        :default => 10
    t.integer  "e_value_cutoff",                            :default => 1
    t.integer  "max_var_mods",                              :default => 64
    t.float    "precursor_mass_tolerance",                  :default => 2.0
    t.float    "product_mass_tolerance",                    :default => 0.8
    t.integer  "precursor_mass_search_type", :limit => 255, :default => 2
    t.integer  "product_mass_search_type",   :limit => 255, :default => 1
    t.integer  "l_bound_precursor",                         :default => 1
    t.integer  "u_bound_precursor",                         :default => 6
    t.integer  "min_charge",                                :default => 7
    t.float    "fract_prod_peaks",                          :default => 0.95
    t.float    "peak_cutoff",                               :default => 0.0
    t.integer  "ints_peaks",                                :default => 20
    t.integer  "ion_1_id",                                  :default => 3
    t.integer  "ion_2_id",                                  :default => 5
    t.integer  "enzyme_id",                                 :default => 1
    t.string   "file_extension"
    t.string   "file"
    t.string   "result"
    t.string   "database_title"
    t.integer  "user_id"
    t.integer  "database_version_id"
    t.string   "error_message"
    t.string   "results_file"
    t.boolean  "send_confirmation",                         :default => true
    t.string   "output_type"
    t.boolean  "email",                                     :default => true
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "username"
    t.boolean  "admin",                                 :default => false
    t.boolean  "approved",                              :default => false, :null => false
    t.boolean  "enabled",                               :default => false, :null => false
  end

  add_index "users", ["admin"], :name => "index_users_on_admin"
  add_index "users", ["approved"], :name => "index_users_on_approved"
  add_index "users", ["enabled"], :name => "index_users_on_enabled"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end

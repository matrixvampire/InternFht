# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101020084016) do

  create_table "addresses", :force => true do |t|
    t.string   "buildingnumber"
    t.string   "streetname"
    t.string   "areaname"
    t.string   "city"
    t.string   "zippostal_code"
    t.string   "state_province"
    t.string   "region"
    t.string   "country"
    t.string   "addresstype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses_administrators", :id => false, :force => true do |t|
    t.integer "address_id"
    t.integer "administrator_id"
  end

  create_table "addresses_faculties", :id => false, :force => true do |t|
    t.integer "address_id"
    t.integer "faculty_id"
  end

  create_table "addresses_sites", :id => false, :force => true do |t|
    t.integer "address_id"
    t.integer "site_id"
  end

  create_table "addresses_students", :id => false, :force => true do |t|
    t.integer "address_id"
    t.integer "student_id"
  end

  create_table "administrators", :force => true do |t|
    t.string   "identificationcode"
    t.integer  "people_id"
    t.date     "registereddate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faculties", :force => true do |t|
    t.string   "identificationcode"
    t.integer  "people_id"
    t.string   "jobtitle"
    t.date     "joindate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "peoples", :force => true do |t|
    t.string  "firstname"
    t.string  "middlename"
    t.string  "lastname"
    t.string  "nickname"
    t.integer "user_id"
    t.string  "emailaddress"
    t.string  "phonenumber"
    t.string  "mobilenumber"
    t.string  "faxnumber"
    t.string  "birthdate"
    t.date    "birthdate_ad"
    t.string  "gender"
    t.string  "homepage"
    t.binary  "photo"
  end

  create_table "quotations", :force => true do |t|
    t.string   "author_name"
    t.string   "category"
    t.text     "quote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string   "identification_code"
    t.string   "site_name"
    t.string   "site_type"
    t.string   "site_assoc_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites_associations", :force => true do |t|
    t.integer  "people_id"
    t.integer  "site_id"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "identificationcode"
    t.integer  "people_id"
    t.date     "admissiondate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string  "username"
    t.string  "password_salt"
    t.string  "password_hash"
    t.string  "usertype"
    t.boolean "isvalid"
    t.string  "validation_code"
    t.date    "validity_period"
    t.integer "logged_counter"
  end

  add_index "users", ["username"], :name => "username_index", :unique => true

end

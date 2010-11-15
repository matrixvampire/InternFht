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

ActiveRecord::Schema.define(:version => 20101108064803) do

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

  create_table "article_comments", :force => true do |t|
    t.integer  "content_id"
    t.integer  "article_id"
    t.integer  "commentor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.integer  "content_id"
    t.integer  "people_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "broadcasts", :force => true do |t|
    t.integer  "content_id"
    t.integer  "administrator_id"
    t.date     "releasedate"
    t.date     "expirationdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commentors", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "homepage"
    t.integer  "people_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_versions", :force => true do |t|
    t.integer  "content_id"
    t.string   "title"
    t.text     "digest"
    t.text     "body"
    t.string   "contentstatus"
    t.datetime "versiondate"
    t.datetime "contentstatusdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", :force => true do |t|
    t.string   "contenttype"
    t.datetime "creationdate"
    t.integer  "latest_version_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents_tags", :id => false, :force => true do |t|
    t.integer "content_id"
    t.integer "tag_id"
  end

  create_table "discussions", :force => true do |t|
    t.integer  "content_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluation_criterias", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluation_enquiries", :force => true do |t|
    t.integer  "evaluation_criteria_id"
    t.string   "question"
    t.string   "relatedto"
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

  create_table "internships", :force => true do |t|
    t.integer  "student_id"
    t.integer  "site_id"
    t.string   "sector"
    t.date     "startdate"
    t.date     "enddate"
    t.boolean  "isreview"
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

  add_index "peoples", ["firstname"], :name => "firstname_index"
  add_index "peoples", ["lastname"], :name => "lastname_index"
  add_index "peoples", ["user_id"], :name => "user_id_index", :unique => true

  create_table "profile_versions", :force => true do |t|
    t.integer  "profile_id"
    t.text     "digest"
    t.text     "body"
    t.datetime "versiondate"
    t.integer  "alteredby_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "profiletype"
    t.integer  "creator_id"
    t.datetime "creationdate"
    t.integer  "latest_version_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotations", :force => true do |t|
    t.string   "author_name"
    t.string   "category"
    t.text     "quote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "replies", :force => true do |t|
    t.integer  "content_id"
    t.integer  "discussion_id"
    t.integer  "commentor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_evaluations", :force => true do |t|
    t.integer  "internship_id"
    t.integer  "evaluation_enquiry_id"
    t.integer  "point"
    t.text     "comment"
    t.date     "evaluationdate"
    t.string   "approvalstatus"
    t.date     "approveddate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_review_comments", :force => true do |t|
    t.integer  "content_id"
    t.integer  "site_review_id"
    t.integer  "commentor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_reviews", :force => true do |t|
    t.integer  "content_id"
    t.integer  "internship_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string   "identificationcode"
    t.string   "sitename"
    t.string   "sitetype"
    t.string   "siteassoc_rating"
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

  create_table "student_evaluations", :force => true do |t|
    t.integer  "internship_id"
    t.integer  "evaluation_enquiry_id"
    t.integer  "point"
    t.text     "comment"
    t.date     "evaluationdate"
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

  create_table "tags", :force => true do |t|
    t.string   "tag_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_logs", :force => true do |t|
    t.integer  "user_id"
    t.datetime "logintime"
    t.datetime "logouttime"
    t.string   "ipaddres"
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

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

ActiveRecord::Schema.define(:version => 20101021163052) do

  create_table "categories", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "ingredients", :force => true do |t|
    t.string    "quantity"
    t.string    "name"
    t.integer   "recipe_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "parsed_quantity"
  end

  add_index "ingredients", ["name"], :name => "index_ingredients_on_name"
  add_index "ingredients", ["recipe_id"], :name => "index_ingredients_on_recipe_id"

  create_table "recipes", :force => true do |t|
    t.text      "directions"
    t.string    "name"
    t.integer   "category_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "slug"
    t.integer   "user_id"
  end

  add_index "recipes", ["category_id"], :name => "index_recipes_on_category_id"
  add_index "recipes", ["name"], :name => "index_recipes_on_name"
  add_index "recipes", ["slug"], :name => "index_recipes_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.integer   "fb_uid"
    t.string    "access_token"
    t.string    "email"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "name"
    t.integer   "sign_in_count",      :default => 0
    t.datetime  "current_sign_in_at"
    t.datetime  "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
  end

  add_index "users", ["fb_uid"], :name => "index_users_on_fb_uid", :unique => true

end

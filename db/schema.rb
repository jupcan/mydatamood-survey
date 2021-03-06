# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_516_232_608) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'categories', force: :cascade do |t|
    t.string 'category', null: false
    t.float 'score', default: 0.0
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'interests', force: :cascade do |t|
    t.string 'user_id', null: false
    t.string 'product_id', null: false
    t.float 'score', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[id product_id], name: 'index_interests_on_id_and_product', unique: true
    t.index ['product_id'], name: 'index_interests_on_product_id'
    t.index ['user_id'], name: 'index_interests_on_user_id'
  end

  create_table 'products', id: :string, force: :cascade do |t|
    t.string 'name', null: false
    t.integer 'category_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.float 'score', default: 0.0
    t.index ['category_id'], name: 'index_products_on_category_id'
  end

  create_table 'users', id: :string, force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'interests', 'products'
  add_foreign_key 'interests', 'users'
  add_foreign_key 'products', 'categories'
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'ffaker'

# To obtain data using item_volume_hash helper.
include HouseholdItemsHelper

# Destroy old data.
ItemTag.destroy_all
Tag.destroy_all
HouseholdItem.destroy_all
Moving.destroy_all
User.destroy_all

# Create sample users.
masa = User.create!(
  username: "Masatoshi",
  email:    "nishiguchi.masa@gmail.com",
  password: "password"
)
taro = User.create!(
  username: "Taro",
  email:    "taro@example.com",
  password: "password"
)
# 3.times do |n|
#   User.create!(
#     username: FFaker::Name.name,
#     email:    "example-#{n+1}@example.com",
#     password: "longpassword"
#   )
# end

# Create a moving project on a user.
name = FFaker::Lorem.sentence
description = FFaker::Lorem.paragraph(1)
masa.movings.create!(name: name, description: description)

# Create items on a moving project.
items = item_volume_hash
item_names = items.keys
moving = masa.movings.first
30.times do
  name = item_names.sample
  volume = items[name]
  quantity = [1,2,3,4].sample
  moving.household_items.create! name: name, volume: volume, quantity: quantity, description: FFaker::Lorem.paragraph(1)
end

# Create tags on household_items
tag_names_1 = ["kitchen", "living room", "bed room", "bathroom", "closet"]
tag_names_2 = %w(a b c)
moving.household_items.each do |item|
  tags_for_this = tag_names_1.sample + ',' + tag_names_2.sample
  item.all_tags = tags_for_this
end

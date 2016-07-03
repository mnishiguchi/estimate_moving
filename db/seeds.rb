# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'ffaker'

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
moving = masa.movings.first
moving.household_items.create!([
  { name: "bad", volume: 100, quantity: 1, description: FFaker::Lorem.paragraph(1) },
  { name: "floor_lamp", volume: 5, quantity: 1, description: FFaker::Lorem.paragraph(1) },
  { name: "sofa", volume: 80, quantity: 1, description: FFaker::Lorem.paragraph(1) },
  { name: "chair", volume: 8, quantity: 1, description: FFaker::Lorem.paragraph(1) },
  { name: "desk", volume: 6, quantity: 1, description: FFaker::Lorem.paragraph(1) }
])

# Create tags on household_items
tag_names = %w(kitcken living_room bed_room)
HouseholdItem.all.each do |item|
  item.tags.create name: tag_names.sample
end

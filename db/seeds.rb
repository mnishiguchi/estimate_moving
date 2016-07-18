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
SocialProfile.destroy_all
User.destroy_all

# Create sample users.
example_user = User.create!(
  username: "Example user",
  email:    "user@example.com",
  confirmed_at: Time.zone.now,
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
example_user.movings.create!(
  name:        FFaker::Address.city,
  description: FFaker::Lorem.sentence,
  unit: 0
)

# Obtain data.
items      = YAML.load_file("#{Rails.root}/config/household_items.yml")
item_names = items.keys

# For the first two users...
User.order(:created_at).take(1).each do |user|
  # Create items on a moving project.
  moving   = user.movings.first
  30.times do
    name     = item_names.sample
    volume   = items[name]
    quantity = [1,2,3,4].sample
    moving.household_items.create!(
      name:        name,
      volume:      volume,
      quantity:    quantity,
      description: FFaker::Lorem.sentence
    )
  end

  # Create tags on household_items
  tag_names = ["kitchen", "living room", "bed room", "bathroom", "closet"]
  moving.household_items.each do |item|
    item.all_tags = tag_names.sample
  end
end

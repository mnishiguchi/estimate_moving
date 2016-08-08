# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'ffaker'

# Destroy old data.
DefaultVolume.destroy_all
ItemTag.destroy_all
Tag.destroy_all
HouseholdItem.destroy_all
Moving.destroy_all
SocialProfile.destroy_all
User.destroy_all

# Obtain a hash of item name to default volume.
ft3_hash = YAML.load_file("#{Rails.root}/db/default_volumes.yml")

# Set default volumes to the default_volumes table.
ft3_hash.each do |name, volume|
  DefaultVolume.create!({ name: name, volume: volume })
end

# Create an admin.
Admin.create!(
  email:    "admin@example.com",
  password: "longpassword"
)

# Create sample users.
example_user = User.create!(
  username: "Example user",
  email:    "user@example.com",
  confirmed_at: Time.zone.now,
  password: "password"
)
3.times do |n|
  User.create!(
    username: "Example user #{n+1}",
    email:    "user-#{n+1}@example.com",
    password: "password"
  )
end

# Create a moving project on a user.
example_user.movings.create!(
  name:        FFaker::Address.city,
  description: FFaker::Lorem.sentence,
  unit: "us"
)

# For a Create items on a moving project.
item_names = ft3_hash.keys
User.order(:created_at).take(1).each do |user|
  moving = user.movings.first
  30.times do
    name     = item_names.sample
    volume   = ft3_hash[name]
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

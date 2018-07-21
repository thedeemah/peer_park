# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Faker::Config.locale = 'en-US'

100.times do |num|
  u = User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password(8),
    encrypted_password: Faker::Internet.password(8),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    cell_number: Faker::PhoneNumber.cell_phone
  )
  Space.create(
    user_id: u.id,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip: Faker::Address.zip
  )

  Vehicle.create(
    user_id: u.id,
    make: Faker::Vehicle.make,
    model: Faker::Vehicle.model,
    color: Faker::Vehicle.color,
    license_plate: "123abc"
  )
end
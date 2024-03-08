# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# User.destroy_all

# User.create email: 'admin@admin.com', password: '111111'

# puts "Usuário criado:"
# puts "login admin@admin.com"
# puts "111111"


# db/seeds.rb

require 'faker'

# Seed users
puts "Seeding users..."
50.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8)
  )
end
puts "Users seeded successfully!"

# Seed people
puts "Seeding people..."
100.times do
  Person.create!(
    name: Faker::Name.name,
    age: Faker::Number.between(from: 18, to: 90)
  )
end
puts "People seeded successfully!"

# Seed debts
puts "Seeding debts..."
500.times do
  Debt.create!(
    amount: Faker::Number.decimal(l_digits: 3, r_digits: 2),
    description: Faker::Lorem.sentence,
    person_id: Faker::Number.between(from: 1, to: 100) # Assuming there are 100 people seeded
  )
end
puts "Debts seeded successfully!"

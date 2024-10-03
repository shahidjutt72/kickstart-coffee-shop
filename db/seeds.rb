# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Product.count == 0
	products = Product.create([
	  { name: 'Coffee', price: 2.99, image: File.open("#{Rails.public_path}/products/coffee.jpg") },
	  { name: 'Sandwich', price: 4.99, image: File.open("#{Rails.public_path}/products/sandwich.jpg") },
	  { name: 'Tea', price: 1.99, image: File.open("#{Rails.public_path}/products/tea.jpg") }
	])
end

# Create an admin user
admin_user = User.find_or_create_by!(email: 'admin@kickstart.com') do |user|
  user.password = 'password'  # Set your desired password
  user.password_confirmation = 'password'
  user.is_admin = true
  user.save!
end

puts "Admin user created with email: #{admin_user.email} and is_admin: #{admin_user.is_admin}"

# Create normal test users
5.times do |i|
  user = User.find_or_create_by!(email: "user#{i+1}@example.com") do |user|
    user.password = 'password123'
    user.password_confirmation = 'password123'
    user.is_admin = false
    user.save!
  end

  puts "Test user created with email: #{user.email} and is_admin: #{user.is_admin}"
end

# Create discount with groups and assign products
discount = Discount.create!(
  rate: 10.0, 
  discount_type: 'percentage'
)

group1 = discount.discount_groups.create!
group1.products << products[0]
group1.products << products[1]

discount_2 = Discount.create!(
  rate: 5, 
  discount_type: 'flat'
)
group2 = discount_2.discount_groups.create!
group2.products << products[0]
group2.products << products[2]
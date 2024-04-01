# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

my_email = 'gorrus100@gmail.com'
admin = User.find_by(email: my_email)
user = User.create(name: Faker::Name.name, email: Faker::Internet.email)
availible_bulletin_states = Bulletin.aasm.states.map(&:name)

car_image_paths = [
  Rails.root.join('test/fixtures/files/cars/first.jpg'),
  Rails.root.join('test/fixtures/files/cars/second.jpeg'),
  Rails.root.join('test/fixtures/files/cars/third.png')
]

tree_image_paths = [
  Rails.root.join('test/fixtures/files/trees/first.jpeg'),
  Rails.root.join('test/fixtures/files/trees/second.jpeg'),
  Rails.root.join('test/fixtures/files/trees/third.jpeg')
]

bridge_image_paths = [
  Rails.root.join('test/fixtures/files/bridges/first.png'),
  Rails.root.join('test/fixtures/files/bridges/second.png'),
  Rails.root.join('test/fixtures/files/bridges/third.png')
]

%w[деревья машины мосты].each do |category|
  Category.create(name: category)
end

car_image_paths.each do |image_path|
  bulletin = user.bulletins.build(
    description: Faker::Lorem.paragraph,
    title: Faker::Lorem.sentence(word_count: 3),
    category: Category.find_by(name: 'машины'),
    state: availible_bulletin_states.sample
  )
  bulletin.image.attach(io: File.open(image_path), filename: 'filename.jpg')
  bulletin.save
  sleep 1
end

tree_image_paths.each do |image_path|
  bulletin = user.bulletins.build(
    description: Faker::Lorem.paragraph,
    title: Faker::Lorem.sentence(word_count: 3),
    category: Category.find_by(name: 'деревья'),
    state: availible_bulletin_states.sample
  )
  bulletin.image.attach(io: File.open(image_path), filename: 'filename.jpg')
  bulletin.save
  sleep 1
end

bridge_image_paths.each do |image_path|
  bulletin = user.bulletins.build(
    description: Faker::Lorem.paragraph,
    title: Faker::Lorem.sentence(word_count: 3),
    category: Category.find_by(name: 'мосты'),
    state: availible_bulletin_states.sample
  )
  bulletin.image.attach(io: File.open(image_path), filename: 'filename.jpg')
  bulletin.save
  sleep 1
end

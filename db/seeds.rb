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

# создание юзеров и 1 админа с определённым email
users = []
my_email = 'gorrus100@gmail.com'
admin = User.find_or_create_by(email: my_email)
admin.name ||= 'Alexey '
admin.save

users << admin
5.times do
  users << User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email
  )
end

# создание категорий
category_cars = Category.find_or_create_by(name: 'машины')
category_trees = Category.find_or_create_by(name: 'деревья')
category_bridges = Category.find_or_create_by(name: 'мосты')

# пути к картинкам в соответствии с категорией
car_image_paths = ['first.jpg', 'second.jpeg', 'third.png'].map do |file_path|
  Rails.root.join("test/fixtures/files/cars/#{file_path}")
end
tree_image_paths = ['first.jpeg', 'second.jpeg', 'third.jpeg'].map do |file_path|
  Rails.root.join("test/fixtures/files/trees/#{file_path}")
end
bridge_image_paths = ['first.png', 'second.png', 'third.png'].map do |file_path|
  Rails.root.join("test/fixtures/files/bridges/#{file_path}")
end

# возможные состояния объявлений
STATES = Bulletin.aasm.states.map(&:name)

# создание объявления
def make_bulletin_by(category, image_paths, users)
  bulletin = users.sample.bulletins.build(
    description: Faker::Lorem.paragraph,
    title: Faker::Lorem.sentence(word_count: 3),
    category:,
    state: STATES.sample
  )
  bulletin.image.attach(io: File.open(image_paths.sample), filename: 'filename.jpg')
  bulletin.save
  sleep 1
end

# создание 60 объявлений
20.times do
  make_bulletin_by(category_cars, car_image_paths, users)
  make_bulletin_by(category_trees, tree_image_paths, users)
  make_bulletin_by(category_bridges, bridge_image_paths, users)
end

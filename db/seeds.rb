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
user = User.find_by(email: my_email)
file_path = Rails.root.join('test/fixtures/files/man.jpg')

if Category.all.empty?
  5.times do |i|
    Category.create(name: "example #{i + 1}")
  end
end

if user
  5.times do
    bulletin = user.bulletins.build(
      description: Faker::Lorem.paragraph,
      title: Faker::Lorem.sentence(word_count: 3),
      category: Category.all.sample
    )
    bulletin.image.attach(io: File.open(file_path), filename: 'filename.jpg')
    bulletin.save!
  end
end

# frozen_string_literal: true

desc 'clear_db'.yellow
task clear_db: :environment do
  Category.destroy_all
  User.destroy_all
end

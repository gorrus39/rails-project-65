# frozen_string_literal: true

desc 'make_me_admin_status'.yellow
task make_me_admin_status: :environment do
  User.find_by(email: 'gorrus100@gmail.com')&.update(admin: true)
end

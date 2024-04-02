# frozen_string_literal: true

class MakeAdminStatusToMyAccount < ActiveRecord::Migration[7.1]
  def change
    my_email = 'gorrus100@gmail.com'
    user = User.find_or_create_by(email: my_email)
    user.update(admin: true)
  end
end

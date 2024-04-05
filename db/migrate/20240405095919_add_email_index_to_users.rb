# frozen_string_literal: true

class AddEmailIndexToUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :email, unique: true
    change_column_null :users, :email, false
  end
end

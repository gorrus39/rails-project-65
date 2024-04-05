# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  admin      :boolean          default(FALSE), not null
#  email      :string           not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end

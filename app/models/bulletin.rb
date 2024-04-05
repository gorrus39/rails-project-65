# frozen_string_literal: true

# == Schema Information
#
# Table name: bulletins
#
#  id          :integer          not null, primary key
#  description :text             not null
#  state       :string           default("draft")
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_bulletins_on_category_id  (category_id)
#  index_bulletins_on_user_id      (user_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  user_id      (user_id => users.id)
#
class Bulletin < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :category

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  aasm column: :state do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category image_attachment image_blob user]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[state title]
  end
end

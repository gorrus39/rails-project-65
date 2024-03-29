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

  validates :title, :description, presence: true
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 1000 }
  validates :image, attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  scope :under_moderation, -> { where(state: :under_moderation) }

  aasm column: :state do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :to_moderage, to: :under_moderation do
      transitions from: :draft
    end

    event :archive, to: :archived do
      transitions from: :draft
      transitions from: :under_moderation
      transitions from: :published
      transitions from: :rejected
    end

    event :publish, to: :published do
      transitions from: :under_moderation
    end

    event :reject, to: :reject do
      transitions from: :under_moderation
    end
  end
end

class State < ApplicationRecord
  validates :status, presence: true
  validates :status, length: { maximum: 30 }
  validate :validate_status_not_including_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  private

  def validate_status_not_including_comma
    errors.add(:status, 'にカンマを含めることはできません') if status&.include?(',')
  end
end

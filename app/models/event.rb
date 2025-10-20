class Event < ApplicationRecord
  # Handles relationship when a user created an event
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  validates :date, :location, presence: true

  has_many :invitations, dependent: :destroy
  has_many :attendees, through: :invitations, source: :attendee

  scope :past, -> { where('date <= ?', Time.now) }
  scope :upcoming, -> { where('date > ?', Time.now) }

  def creator?(user)
    creator == user
  end
end

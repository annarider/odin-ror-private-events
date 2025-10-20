class Event < ApplicationRecord
  # Handles relationship when a user created an event
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  validates :date, :location, presence: true

  has_many :invitations
  has_many :attendees, through: :invitations, source: :attendee

  def self.past
    where('date <= ?', Time.now)
  end

  def self.upcoming
    where('date > ?', Time.now)
  end
end

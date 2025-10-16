class Event < ApplicationRecord
  # Handles relationship when a user created an event
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  validates :date, :location, presence: true
  validates :date, comparison: { greater_than: -> { Time.current } }, on: :create

  has_many :invitations
  has_many :attendees, through: :invitations, source: :attendee
end

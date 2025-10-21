class Invitation < ApplicationRecord
  belongs_to :attendee, class_name: 'User', foreign_key: 'user_id'
  belongs_to :attended_event, class_name: 'Event', foreign_key: 'event_id'

  enum :status, { pending: 0, accepted: 1, declined: 2 }, default: :pending

  validates :attendee, uniqueness: { scope: :attended_event_id, 
                                     message: 'has already been invited to this event'}
end

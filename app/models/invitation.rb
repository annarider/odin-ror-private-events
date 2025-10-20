class Invitation < ApplicationRecord
  belongs_to :attendee, class_name: 'User', foreign_key: 'user_id'
  belongs_to :attended_event, class_name: 'Event', foreign_key: 'event_id'

  validates :attendee, uniqueness: { scope: :attended_event_id, 
                                     message: 'has already been invited to this event'}
end

class Event < ApplicationRecord
  # Handles relationship when a user created an event
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
end

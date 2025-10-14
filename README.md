# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version


ruby 3.4.2 (2025-02-15 revision d2930f8e7a) +PRISM [arm64-darwin24]

* System dependencies

* Configuration

* Data model for Private Events
User (parent)
Devise fields, e.g. email, password
has_many :invitations
has_many :invitees, through: :invitations, source: :event
has_many :created_events, class_name: 'Event', foreign_key: 'host_id'

Event (parent)
date:datetime
location:string
belongs_to :host, class_name: 'User', foreign_key: 'host_id'
has_many :invitations
has_many :invitees, through :invitations, source: :user

Invitation (M:M join)
status:enum ['pending', 'accepted', 'declined']
belongs_to :event
belongs_to :user

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

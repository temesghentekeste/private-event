class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :event_attendees, through: :event_attendances, source: :event_attendee

  scope :past, -> { where('start_datetime < ?', DateTime.now) }

  def self.upcoming
     where('start_datetime > ?', DateTime.now)
  end
end

class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :event_attendees, through: :event_attendances, source: :event_attendee

  scope :past, -> { where('start_datetime < ?', DateTime.now) }
  scope :upcoming, -> { where('start_datetime >= ?', DateTime.now) }

  def self.invitees(id)
    invitees = User.find(Event.find(id).event_attendances.invited.map { |enr| enr.event_attendee_id }) 
    invitees = invitees.count > 0 ? invitees : "Currently there are no any invitees."

  end

  def self.attendees(id)
    attendees = User.find(Event.find(id).event_attendances.accepted.map { |enr| enr.event_attendee_id })
    attendees = attendees.count > 0 ? attendees : "Currently there are no any attendees"
  end

end

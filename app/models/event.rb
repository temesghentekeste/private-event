class Event < ApplicationRecord
  validates :title, length: { minimum: 3, maximum: 50 }
  validates :title, :description, presence: true
  validates :description, length: { minimum: 3, maximum: 500 }
  validates :start_datetime, :end_datetime, presence: true

  validate :end_date_is_after_start_date

  belongs_to :creator, class_name: 'User'

  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :event_attendees, through: :event_attendances, source: :event_attendee

  scope :past, -> { where('start_datetime < ?', DateTime.now) }
  scope :upcoming, -> { where('start_datetime >= ?', DateTime.now) }

  def self.invitees(id)
    invitees = User.find(Event.find(id).event_attendances.invited.map(&:event_attendee_id))
    invitees.count.positive? ? invitees : 'Currently there are no any invitees.'
  end

  def self.attendees(id)
    attendees = User.find(Event.find(id).event_attendances.accepted.map(&:event_attendee_id))
    attendees.count.positive? ? attendees : 'Currently there are no any attendees'
  end

  paginates_per 2

  private

  def end_date_is_after_start_date
    return if end_datetime.blank? || start_datetime.blank?

    errors.add(:end_datetime, 'cannot be before the start date') if end_datetime < start_datetime
  end
end

class EventAttendance < ApplicationRecord
  enum invitation_status: { invited: 0, accepted: 1 }

  belongs_to :event_attendee, class_name: "User"
  belongs_to :attended_event, class_name: "Event"
end
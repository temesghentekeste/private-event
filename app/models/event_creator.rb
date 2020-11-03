class EventCreator < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :created_event, class_name: "Event"

end

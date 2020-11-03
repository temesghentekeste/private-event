class Event < ApplicationRecord
  has_many :event_creators, foreign_key: :created_event_id
  has_many :creators, through: :event_creators, source: :creator
end

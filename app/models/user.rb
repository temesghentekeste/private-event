class User < ApplicationRecord
  has_many :events, foreign_key: :creator_id, class_name: "Event"

  has_many :event_attendances, foreign_key: :event_attendee_id
  has_many :attended_events, through: :event_attendances, source: :attended_event



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }

  validates :email, presence: true, length: { maximum: 105 },
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end

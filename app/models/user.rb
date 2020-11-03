class User < ApplicationRecord
  has_many :event_creators, foreign_key: :creator_id
  has_many :events, through: :event_creators, source: :created_event

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }

  validates :email, presence: true, length: { maximum: 105 },
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end

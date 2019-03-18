class Event < ApplicationRecord
  belongs_to :partner

  has_many :event_majors
  has_many :majors, through: :event_majors
  has_many :user_lead_events
  has_many :leaders, through: :user_lead_events

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true
  validates :max_participants, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :semester, presence: true
end

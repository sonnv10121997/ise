class Event < ApplicationRecord
  belongs_to :partner

  has_many :user_enroll_events
  has_many :event_requirements, class_name: UserEventRequirement.name,
    foreign_key: :event_id
  has_many :event_majors
  has_many :user_lead_events
  has_many :leaders, through: :user_lead_events
  has_many :majors, through: :event_majors

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true
  validates :max_participants, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :semester, presence: true
end

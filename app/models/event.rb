class Event < ApplicationRecord
  has_many :event_majors
  has_many :majors, through: :event_majors

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true
  validates :max_participants, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :semester, presence: true
end

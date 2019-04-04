class Major < ApplicationRecord
  has_many :event_majors, dependent: :destroy
  has_many :events, through: :event_majors

  validates_presence_of :name, :acronym
end

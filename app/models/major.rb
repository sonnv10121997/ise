class Major < ApplicationRecord
  has_many :event_majors
  has_many :events, through: :event_majors
end

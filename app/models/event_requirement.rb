class EventRequirement < ApplicationRecord
  belongs_to :requirement
  belongs_to :event, inverse_of: :requirement_details

  has_many :user_event_requirements, dependent: :destroy

  delegate :name, to: :requirement, allow_nil: true

  validates_presence_of :deadline
end

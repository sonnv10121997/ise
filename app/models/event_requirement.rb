class EventRequirement < ApplicationRecord
  belongs_to :requirement
  belongs_to :event

  delegate :name, :description, to: :requirement
end

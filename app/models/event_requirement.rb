class EventRequirement < ApplicationRecord
  belongs_to :requirement
  belongs_to :event
end

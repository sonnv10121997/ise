class UserEventRequirement < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :requirement
end

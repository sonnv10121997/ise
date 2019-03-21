class UserEventRequirement < ApplicationRecord
  belongs_to :user
  belongs_to :event_requirement, class_name: Event.name, foreign_key: :event_id
  belongs_to :requirement

  scope :by_user, ->(user_id) {where(user_id: user_id).order :verified}
end

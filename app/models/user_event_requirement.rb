class UserEventRequirement < ApplicationRecord
  belongs_to :user
  belongs_to :event_requirement, class_name: Event.name, foreign_key: :event_id
  belongs_to :requirement

  has_many :images, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: proc {|attributes| attributes["file"].blank?}

  scope :by_user, ->(user_id) {where(user_id: user_id).order :verified}
end

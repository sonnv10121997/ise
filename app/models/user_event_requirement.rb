class UserEventRequirement < ApplicationRecord
  belongs_to :user
  belongs_to :detail, class_name: EventRequirement.name,
    foreign_key: :event_requirement_id

  has_many :images, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: proc {|attributes| attributes["file"].blank?}

  delegate :deadline, to: :detail
end

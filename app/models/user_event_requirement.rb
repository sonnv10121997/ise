class UserEventRequirement < ApplicationRecord
  belongs_to :user
  belongs_to :detail, class_name: EventRequirement.name,
    foreign_key: :event_requirement_id

  has_many :images, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: proc {|attributes| attributes["file"].blank?}

  delegate :deadline, to: :detail
  delegate :event_id, to: :detail
  delegate :event, to: :detail
  delegate :requirement, to: :detail

  scope :by, (lambda do |user_id, event_id|
      joins(:detail).where("user_id = ? AND event_requirements.event_id = ?",
        user_id, event_id).order verified: :desc
    end)
end

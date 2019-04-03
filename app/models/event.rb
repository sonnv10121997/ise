class Event < ApplicationRecord
  include FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :partner

  has_many :participant_details, class_name: UserEnrollEvent.name,
    foreign_key: :event_id, inverse_of: :event
  has_many :requirement_details, class_name: EventRequirement.name,
    foreign_key: :event_id, inverse_of: :event
  has_many :event_majors
  has_many :majors, through: :event_majors
  has_many :participants, source: :user, through: :participant_details
  has_many :requirements, through: :requirement_details
  has_one :thumbnail, as: :imageable, class_name: Image.name, dependent: :destroy

  accepts_nested_attributes_for :thumbnail, allow_destroy: true
  accepts_nested_attributes_for :requirement_details, allow_destroy: true
  accepts_nested_attributes_for :participant_details, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates_presence_of :description, :price, :max_participants, :start_date,
    :end_date, :semester, :thumbnail, :joined_participants, :requirement_details,
    :majors, :participant_details
end

class Event < ApplicationRecord
  include FriendlyId
  friendly_id :name, use: :slugged

  enum status: %i(unpublish publish enrolling ongoing finished)

  belongs_to :partner
  belongs_to :leader, class_name: User.name

  has_many :participant_details, class_name: UserEnrollEvent.name,
    foreign_key: :event_id, inverse_of: :event, dependent: :destroy
  has_many :requirement_details, class_name: EventRequirement.name,
    foreign_key: :event_id, inverse_of: :event, dependent: :destroy
  has_many :event_majors, dependent: :destroy
  has_many :majors, through: :event_majors
  has_many :participants, source: :user, through: :participant_details
  has_many :requirements, through: :requirement_details
  has_one :thumbnail, as: :imageable, class_name: Image.name, dependent: :destroy

  accepts_nested_attributes_for :thumbnail, allow_destroy: true
  accepts_nested_attributes_for :requirement_details, allow_destroy: true
  accepts_nested_attributes_for :participant_details, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates_presence_of :description, :price, :max_participants, :start_date,
    :end_date, :semester, :thumbnail, :joined_participants, :majors,
    :requirement_details
end

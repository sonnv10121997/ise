class Event < ApplicationRecord
  include FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :partner

  has_many :user_enroll_events
  has_many :event_requirements
  has_many :event_majors
  has_many :user_lead_events
  has_many :leaders, through: :user_lead_events
  has_many :majors, through: :event_majors
  has_many :participants, through: :user_enroll_events
  has_many :requirements, through: :event_requirements
  has_one :thumbnail, as: :imageable, dependent: :destroy, class_name: Image.name

  accepts_nested_attributes_for :thumbnail, allow_destroy: true,
    reject_if: proc {|attributes| attributes["file"].blank?}

  validates :name, presence: true, uniqueness: true
  validates_presence_of :description, :price, :max_participants, :start_date,
    :end_date, :semester, :leaders, :majors, :requirements, :thumbnail,
    :joined_participants
end

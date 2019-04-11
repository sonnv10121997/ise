class EventRequirement < ApplicationRecord
  belongs_to :requirement
  belongs_to :event, inverse_of: :requirement_details

  has_many :user_event_requirements, dependent: :destroy

  delegate :name, to: :requirement, allow_nil: true

  validates_presence_of :deadline
  validate :validate_deadline
  validates_uniqueness_of :requirement, scope: :event

  private

  def validate_deadline
    if deadline >= event.end_date
      errors.add :deadline, "#{I18n.t ".validate_deadline"}"
    end
  end
end

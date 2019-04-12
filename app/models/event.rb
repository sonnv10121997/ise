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

  scope :latest, (lambda do
      where(status: [Event.statuses.values[1], Event.statuses.values[2]])
      .order created_at: :desc
    end)

  scope :most_popular, (lambda do
      select("events.*, COUNT(user_enroll_events.event_id) AS participants")
      .joins(:participant_details)
      .where(status: [Event.statuses.values[1], Event.statuses.values[2]])
      .group("user_enroll_events.event_id")
      .order "participants DESC"
    end)

  validates :name, presence: true, uniqueness: true,
    format: {with: Regexp.new(Settings.regex.only_word)}
  validates_presence_of :description, :price, :max_participants, :start_date,
    :end_date, :semester, :thumbnail, :joined_participants, :requirement_details,
    :event_majors
  validates :price, numericality: true
  validate :validate_price
  validate :number_of_participants
  validate :end_date_is_after_start_date

  private

  def number_of_participants
    if max_participants.negative?
      errors.add :max_participants,
        "#{I18n.t(".validate_max_participants", number: Settings.model.event.zero)}"
    end
    if joined_participants.negative?
      errors.add :joined_participants,
        "#{I18n.t(".validate_joined_participants", number: Settings.model.event.zero)}"
    end
    if max_participants < joined_participants
      errors.add :joined_participants, "#{I18n.t ".validate_participants"}"
    end
  end

  def validate_price
    if price.negative?
      errors.add :price,
        "#{I18n.t(".validate_price", number: Settings.model.event.zero)}"
    end
  end

  def end_date_is_after_start_date
    errors.add(:end_date, "#{I18n.t ".valid_end_date"}") if end_date <= start_date
  end
end

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

  scope :latest, ->{order created_at: :desc}
  scope :most_popular, (lambda do find_by_sql [
    "SELECT events.*, COUNT(user_enroll_events.event_id) AS participants
    FROM events INNER JOIN user_enroll_events
    ON user_enroll_events.event_id = events.id
    WHERE events.status IN (?)
    GROUP BY user_enroll_events.event_id
    ORDER BY participants DESC", [Event.statuses.values[1], Event.statuses.values[2]]]
  end)

  validates :name, presence: true, uniqueness: true,
    format: {with: Regexp.new(Settings.regex.only_word)}
  validates_presence_of :description, :price, :max_participants, :start_date,
    :end_date, :semester, :thumbnail, :joined_participants, :majors, :requirement_details
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

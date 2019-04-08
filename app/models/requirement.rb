class Requirement < ApplicationRecord
  include FriendlyId
  friendly_id :name, use: :slugged

  has_many :event_requirements, dependent: :destroy
  has_many :events, through: :event_requirements

  validates :name, presence: true, uniqueness: true,
    format: {with: Regexp.new(Settings.regex.word_with_number)}
end

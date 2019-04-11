class Major < ApplicationRecord
  has_many :event_majors, dependent: :destroy
  has_many :events, through: :event_majors

  validates_presence_of :name, :acronym
  validates :name, format: {with: Regexp.new(Settings.regex.only_word)}
  validates :acronym, format: {with: Regexp.new(Settings.regex.upper_case)}
end

class Mou < ApplicationRecord
  belongs_to :partner

  validates :name, presence: true,
    format: {with: Regexp.new(Settings.regex.word_with_number)}
  validates_presence_of :start_date, :end_date
end

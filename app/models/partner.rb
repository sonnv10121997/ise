class Partner < ApplicationRecord
  include FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true,
    format: {with: Regexp.new(Settings.regex.word_with_number)}
  validates_presence_of :address, :country
end

class Requirement < ApplicationRecord
  include FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name, :description
end

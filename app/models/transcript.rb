class Transcript < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_many :grade_categories, dependent: :destroy, inverse_of: :transcript

  accepts_nested_attributes_for :grade_categories, allow_destroy: true

  validates_presence_of :grade_categories
end

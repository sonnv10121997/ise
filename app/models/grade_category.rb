class GradeCategory < ApplicationRecord
  belongs_to :transcript, inverse_of: :grade_categories

  has_many :grades, inverse_of: :grade_category, dependent: :destroy

  accepts_nested_attributes_for :grades, allow_destroy: true

  validates_presence_of :name, :grades
end

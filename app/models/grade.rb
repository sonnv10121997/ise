class Grade < ApplicationRecord
  belongs_to :grade_category, inverse_of: :grades

  validates_presence_of :name, :weight
end

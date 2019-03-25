class Transcript < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_many :grade_categories, ->{where grade_category_id: nil}
  has_many :grades, ->{where.not grade_category_id: nil},
    class_name: GradeCategory.name, foreign_key: :grade_category_id
end

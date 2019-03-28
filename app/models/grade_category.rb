class GradeCategory < ApplicationRecord
  belongs_to :transcript

  has_many :grades, foreign_key: :grade_category_id,
    class_name: GradeCategory.name

  validates_presence_of :name, :weight
end

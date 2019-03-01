class Grade < ApplicationRecord
  belongs_to :transcript
  belongs_to :grade_category, class_name: Grade.name
end

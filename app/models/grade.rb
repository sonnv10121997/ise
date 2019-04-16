class Grade < ApplicationRecord
  belongs_to :grade_category, inverse_of: :grades

  validates_presence_of :name, :weight
  validate :check_values

  private

  def check_values
    return unless value.negative?
    errors.add :value, "#{I18n.t ".validate_grade_value"}"
  end
end

class CreateGradeCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :grade_categories do |t|
      t.string :name
      t.references :transcript, foreign_key: true

      t.timestamps
    end
  end
end

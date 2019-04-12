class CreateGradeCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :grade_categories do |t|
      t.string :name, null: false
      t.references :transcript, foreign_key: true, null: false

      t.timestamps
    end
  end
end

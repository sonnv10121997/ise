class CreateGrade < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.string :name, null: false
      t.float :weight, null: false
      t.float :value
      t.references :grade_category, foreign_key: true, null: false

      t.timestamps
    end
  end
end

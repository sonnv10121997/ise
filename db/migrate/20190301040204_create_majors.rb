class CreateMajors < ActiveRecord::Migration[5.2]
  def change
    create_table :majors do |t|
      t.string :name, null: false
      t.string :acronym, null: false

      t.timestamps
    end
  end
end

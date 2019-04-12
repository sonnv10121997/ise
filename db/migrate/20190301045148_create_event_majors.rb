class CreateEventMajors < ActiveRecord::Migration[5.2]
  def change
    create_table :event_majors do |t|
      t.references :event, foreign_key: true, null: false
      t.references :major, foreign_key: true, null: false

      t.timestamps
    end
  end
end

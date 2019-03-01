class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :max_participants
      t.integer :joined_participants
      t.date :start_date
      t.date :end_date
      t.string :semester
      t.string :country

      t.timestamps
    end
  end
end

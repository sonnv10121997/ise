class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.references :leader, foreign_key: {to_table: :users}, null: false
      t.integer :status, default: Event.statuses.values.first
      t.float :price, null: false
      t.integer :max_participants, null: false
      t.integer :joined_participants, default: 0
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :semester, null: false

      t.timestamps
    end
  end
end

class CreateMmos < ActiveRecord::Migration[5.2]
  def change
    create_table :mmos do |t|
      t.string :name, null: false
      t.references :partner, foreign_key: true, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end

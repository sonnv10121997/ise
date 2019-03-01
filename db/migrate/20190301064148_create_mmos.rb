class CreateMmos < ActiveRecord::Migration[5.2]
  def change
    create_table :mmos do |t|
      t.string :name
      t.references :partner, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end

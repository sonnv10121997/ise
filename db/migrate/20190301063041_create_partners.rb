class CreatePartners < ActiveRecord::Migration[5.2]
  def change
    create_table :partners do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :country, null: false
      t.boolean :signed, default: false

      t.timestamps
    end
  end
end

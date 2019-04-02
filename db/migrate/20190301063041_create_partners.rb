class CreatePartners < ActiveRecord::Migration[5.2]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :address
      t.string :country
      t.boolean :signed, default: false

      t.timestamps
    end
  end
end

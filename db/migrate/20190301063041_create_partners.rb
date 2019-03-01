class CreatePartners < ActiveRecord::Migration[5.2]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :address
      t.string :country
      t.integer :status

      t.timestamps
    end
  end
end

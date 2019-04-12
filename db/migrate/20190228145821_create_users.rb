class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :gender, null: false
      t.date :dob, null: false
      t.string :code, null: false
      t.string :phone, null: false
      t.string :type, default: Student.name

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :gender
      t.date :dob
      t.string :code
      t.string :phone
      t.string :type, default: Student.name

      t.timestamps
    end
  end
end

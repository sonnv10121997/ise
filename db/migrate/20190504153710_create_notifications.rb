class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :type, null: false
      t.references :event, foreign_key: true
      t.references :receiver, foreign_key: {to_table: :users}, null: false
      t.references :notifier, foreign_key: {to_table: :users}, null: false
      t.references :requirement, foreign_key: true
      t.references :message, foreign_key: true

      t.timestamps
    end
  end
end

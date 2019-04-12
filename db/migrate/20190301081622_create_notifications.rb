class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :content, null: false
      t.references :event, foreign_key: true, null: false
      t.references :receiver, foreign_key: {to_table: :users}, null: false
      t.references :notifier, foreign_key: {to_table: :users}, null: false

      t.timestamps
    end
  end
end

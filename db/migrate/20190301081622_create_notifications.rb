class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :content
      t.references :event, foreign_key: true
      t.references :receiver, foreign_key: {to_table: :users}
      t.references :notifier, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end

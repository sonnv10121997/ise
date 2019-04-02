class CreateUserEventRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :user_event_requirements do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.references :requirement, foreign_key: true
      t.date :deadline
      t.boolean :verified, default: false

      t.timestamps
    end
  end
end

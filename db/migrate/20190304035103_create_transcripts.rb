class CreateTranscripts < ActiveRecord::Migration[5.2]
  def change
    create_table :transcripts do |t|
      t.float :total
      t.references :user, foreign_key: true, null: false
      t.references :event, foreign_key: true, null: false

      t.timestamps
    end
  end
end

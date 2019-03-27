class CreateEventRequirement < ActiveRecord::Migration[5.2]
  def change
    create_table :event_requirements do |t|
      t.references :event, foreign_key: true
      t.references :requirement, foreign_key: true
    end
  end
end

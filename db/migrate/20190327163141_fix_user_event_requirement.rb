class FixUserEventRequirement < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_event_requirements, :event_id
    remove_column :user_event_requirements, :requirement_id
    add_reference :user_event_requirements, :event_requirement, foreign_key: true
  end
end

class FixUserEventRequirementRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_event_requirements, :deadline
    add_column :event_requirements, :deadline, :date
    add_column :event_requirements, :description, :string
  end
end

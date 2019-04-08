class AddStatusToUserEnrollEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :user_enroll_events, :enrolled, :boolean, default: false
  end
end

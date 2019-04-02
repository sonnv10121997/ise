class AddStatusToUserEnrollEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :user_enroll_events, :status, :integer, default: UserEnrollEvent.statuses.first[1]
  end
end

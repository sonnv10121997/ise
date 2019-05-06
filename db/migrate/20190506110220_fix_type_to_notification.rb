class FixTypeToNotification < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :type, :notification_type
    add_column :notifications, :read, :boolean, default: false
  end
end

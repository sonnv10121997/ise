class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.page(params[:page])
      .per Settings.model.notification.list
  end

  def update
    Notification.where(receiver_id: current_user, read: false).in_batches
      .update_all read: true
  end
end

class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform notification, text, noty_type = "alert"
    ActionCable.server.broadcast "notifications:#{notification.receiver_id}",
      notification: {html: render_notification(notification), text: text,
      noty_type: noty_type, type: notification.notification_type}
  end

  private

  def render_notification notification
    ApplicationController.render partial: "notifications/show",
      locals: {notification: notification}
  end
end

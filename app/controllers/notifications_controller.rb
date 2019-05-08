class NotificationsController < ApplicationController
  attr_reader :event

  before_action ->{find_event params[:event_id]}, only: :create

  def index
    @notifications = current_user.notifications.page(params[:page])
      .per Settings.model.notification.list
  end

  def create
    create_notification event, nil, nil, current_user, event.leader,
      Notification.types.values[10], "warning"
  end

  def update
    Notification.where(receiver_id: current_user, read: false).in_batches
      .update_all read: true
  end
end

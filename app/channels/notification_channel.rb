class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications:#{params[:current_user_id]}"
  end
end

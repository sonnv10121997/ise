module NotificationsHelper
  def rescue_noti_status is_read
    return "not_read" unless is_read
  end
end

module EnrollHelper
  def current_user_is_enrolling(user_id, event_id)
    relationship = UserEnrollEvent.find_by(user_id: user_id, event_id: event_id)
    return true if relationship
  end
end

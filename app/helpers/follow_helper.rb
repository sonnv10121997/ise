module FollowHelper
  def current_user_is_following(user_id, event_id)
    relationship = UserFollowEvent.find_by(user_id: user_id, event_id: event_id)
    return true if relationship
  end
end

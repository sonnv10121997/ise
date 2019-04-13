module RequirementsHelper
  def rescue_req_deadline req
    req.deadline&.strftime Settings.model.event.date_format
  end

  def req_verified? req
    return fa_icon "check", class: "pass" if req.verified?
    fa_icon "times", class: "failed"
  end

  def verify_req req
    return fa_icon "times", class: "failed" if req.verified?
    fa_icon "check", class: "pass"
  end

  def requirement_collection event, conversation
    return UserEventRequirement.by(current_user, event) if current_user.Student?
    UserEventRequirement.by(conversation.recipient(current_user), event)
  end
end

module RequirementsHelper
  def rescue_req_deadline req
    req.deadline&.strftime Settings.model.event.date_format
  end

  def req_verified? verified
    return fa_icon "check", class: "pass" if verified
    fa_icon "times", class: "failed"
  end

  def verify_req verified
    return fa_icon "times", class: "failed" if verified
    fa_icon "check", class: "pass"
  end

  def requirement_collection event, conversation
    return UserEventRequirement.by(current_user, event) if current_user.Student?
    UserEventRequirement.by conversation.recipient(current_user), event
  end
end

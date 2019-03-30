module RequirementsHelper
  def rescue_req_deadline req
    req.deadline ? req.deadline.strftime(Settings.model.event.date_format) : ""
  end

  def req_verified? req
    return fa_icon "check", class: "pass" if req.verified?
    fa_icon "times", class: "failed"
  end

  def verify_req req
    return fa_icon "times", class: "failed" if req.verified?
    fa_icon "check", class: "pass"
  end

  def requirement_collection conversation
    current_user.Student? ? current_user.requirements : conversation.receiver.requirements
  end
end

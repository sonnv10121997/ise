module RequirementsHelper
  def rescue_req_deadline req
    req.deadline ? req.deadline.strftime(Settings.model.event.date_format) : ""
  end
end

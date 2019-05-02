class UserRequirementBroadcastJob < ApplicationJob
  queue_as :default

  def perform requirement, method
    if method == "check_requirement"
      ActionCable.server.broadcast \
        "events:#{requirement.event_id}:requirements",
        requirement: {status: render_status(requirement),
        user_id: requirement.user_id, id: requirement.id}, method: method
    elsif method == "upload_image"
      ActionCable.server.broadcast \
        "events:#{requirement.event_id}:requirements",
        requirement: {image: render_image(requirement),
        user_id: requirement.user_id, id: requirement.id},  method: method
    end
  end

  private

  def render_status requirement
    UserEventRequirementsController.render partial: "requirements/status",
      locals: {requirement: requirement}
  end

  def render_image requirement
    UserEventRequirementsController.render partial: "requirements/image",
      collection: requirement.images.reject(&:new_record?)
  end
end

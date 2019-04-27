class UserRequirementBroadcastJob < ApplicationJob
  queue_as :default

  def perform requirement, method
    if method == "check_requirement"
      ActionCable.server.broadcast "events:#{requirement.event_id}",
        requirement: {status: render_status(requirement),
        user_id: requirement.user_id, id: requirement.id}, method: method
    elsif method == "upload_image"
      ActionCable.server.broadcast "events:#{requirement.event_id}",
        requirement: {image: render_image(requirement.images.last),
        user_id: requirement.user_id, id: requirement.id},  method: method
    end
  end

  private

  def render_status requirement
    UserEventRequirementsController.render partial: "requirements/status",
      locals: {requirement: requirement}
  end

  def render_image image
    UserEventRequirementsController.render partial: "requirements/image",
      locals: {image: image}
  end
end

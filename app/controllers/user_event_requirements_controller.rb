class UserEventRequirementsController < ApplicationController
  attr_reader :user_event_requirement

  before_action :find_user_event_requirement
  authorize_resource

  def upload_image
    user_event_requirement.update_attributes upload_image_params
    broadcast_requirement "upload_image"
    redirect_back fallback_location: root_path
  end

  def check_requirement
    user_event_requirement.update_attributes check_requirement_params
    broadcast_requirement "check_requirement"
  end

  private

  def check_requirement_params
    params.require(:user_event_requirement).permit :id, :user_id, :event_id,
      :deadline, :requirement_id, :verified,
      images_attributes: [:id, :file, :file_cache, :_destroy]
  end

  def upload_image_params
    params.require(:user_event_requirement).permit :id, :user_id, :event_id,
      :requirement_id, images_attributes: [:id, :file, :file_cache, :_destroy]
  end

  def find_user_event_requirement
    @user_event_requirement = UserEventRequirement.find_by id: params[:id]
  end

  def broadcast_requirement method
    UserRequirementBroadcastJob.perform_now user_event_requirement, method
  end
end

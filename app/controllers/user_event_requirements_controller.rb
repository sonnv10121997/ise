class UserEventRequirementsController < ApplicationController
  attr_reader :user_event_requirement

  before_action :find_user_event_requirement

  def update
    user_event_requirement.update_attributes user_event_requirement_params
  end

  private

  def user_event_requirement_params
    params.require(:user_event_requirement).permit :id, :user_id, :event_id,
      :deadline, :requirement_id, :verified,
      images_attributes: [:id, :file, :file_cache, :_destroy]
  end

  def find_user_event_requirement
    @user_event_requirement = UserEventRequirement.find_by id: params[:id]
  end
end

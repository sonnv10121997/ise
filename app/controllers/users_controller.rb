class UsersController < ApplicationController
  attr_reader :user

  before_action ->{find_user params[:id]}
  authorize_resource

  def show
    user.build_avatar unless user.avatar
  end

  def update
    user.update_attributes user_params
  end

  private

  def user_params
    params.require(:user).permit :id, avatar_attributes: [:id, :file,
      :file_cached, :_destroy]
  end
end

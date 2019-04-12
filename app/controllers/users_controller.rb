class UsersController < ApplicationController
  attr_reader :user

  before_action ->{find_user params[:id]}, except: :index
  authorize_resource

  def index
    redirect_to root_path and return
  end

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

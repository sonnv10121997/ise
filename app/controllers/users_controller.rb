class UsersController < ApplicationController
  attr_reader :user

  before_action :find_user

  def show
    user.build_avatar
  end

  def update
    user.update_attributes user_params
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
  end

  def user_params
    params.require(:user).permit :id, avatar_attributes: [:id, :file,
      :file_cached, :_destroy]
  end
end

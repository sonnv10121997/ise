class EventsController < ApplicationController
  def index
    return redirect_to new_user_session_path if !user_signed_in?
  end
end

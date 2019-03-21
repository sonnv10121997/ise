class UserFollowEventController < ApplicationController
  attr_reader :event

  before_action :find_user_event

  def create
    current_user.user_follow_events.create event_id: event.id
    respond_to do |format|
      format.js {render "events/follow"}
    end
  end

  def destroy
    current_user.user_follow_events.find_by(event_id: event.id).destroy
    respond_to do |format|
      format.js {render "events/unfollow"}
    end
  end
end

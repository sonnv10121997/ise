class UserEnrollEventsController < ApplicationController
  attr_reader :user_event

  before_action :find_user_event

  def show; end

  def create
    current_user.user_enroll_events.create event_id: user_event.id
    respond_to do |format|
      format.js {render "events/show", event: user_event}
    end
  end

  def destroy
    current_user.user_enroll_events.find_by(event_id: user_event.id).destroy
    respond_to do |format|
      format.js {render "events/show", event: user_event}
    end
  end
end

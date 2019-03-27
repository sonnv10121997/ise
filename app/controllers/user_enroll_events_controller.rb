class UserEnrollEventsController < ApplicationController
  attr_reader :user_event, :user_enroll_event

  before_action ->{find_user_event params[:event_id]}
  before_action :find_user_enroll_event

  def show; end

  def create
    current_user.user_enroll_events.create event_id: user_event.id
    respond_to do |format|
      format.js {render "events/show", event: user_event}
    end
  end

  def destroy
    user_enroll_event.destroy
    respond_to do |format|
      format.js {render "events/show", event: user_event}
    end
  end

  private

  def find_user_enroll_event
    @user_enroll_event = current_user.user_enroll_events.find_by_event_id user_event
  end
end

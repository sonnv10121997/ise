class UserEnrollEventsController < ApplicationController
  attr_reader :user_event, :user_enroll_event

  before_action ->{find_user_event params[:event_id]}
  before_action ->{find_conversation current_user,
    user_event.participants.where.not(id: current_user).first}
  before_action :find_user_enroll_event, only: :destroy

  def show; end

  def create
    current_user.user_enroll_events.create event_id: user_event.id
    create_user_event_requirement
    respond_to do |format|
      format.js {render "events/show", event: user_event}
    end
  end

  def destroy
    user_enroll_event.destroy
    UserEventRequirement.where(user_id: current_user.id).delete_all
    respond_to do |format|
      format.js {render "events/show", event: user_event}
    end
  end

  private

  def find_user_enroll_event
    @user_enroll_event = current_user.user_enroll_events.find_by_event_id user_event
  end

  def create_user_event_requirement
    user_event.event_requirements.ids.each do |event_requirement_id|
      UserEventRequirement.create user_id: current_user.id,
        event_requirement_id: event_requirement_id, verified: false
    end
  end
end

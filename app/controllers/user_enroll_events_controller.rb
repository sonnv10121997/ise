class UserEnrollEventsController < ApplicationController
  attr_reader :user_event, :user_enroll_event, :user

  before_action ->{find_user_event params[:event_id]}, except: :index
  before_action :rescue_conversation, only: :show
  before_action :find_user_enroll_event, only: %i(update destroy)

  def index
    @user_events = Event.joins(:participant_details)
      .where("events.leader_id = ? OR user_enroll_events.user_id = ?",
      current_user.id, current_user.id).distinct
  end

  def show; end

  def create
    current_user.user_enroll_events.create event_id: user_event.id
    create_user_event_requirement
    respond_to do |format|
      format.js {render "events/show", event: user_event}
    end
  end

  def update
    user_enroll_event.update_attributes user_enroll_event_params
  end

  def destroy
    user_enroll_event.destroy
    UserEventRequirement.where(user_id: user.id).delete_all
    respond_to do |format|
      format.js {render "events/show", event: user_event}
    end
  end

  private

  def find_user_enroll_event
    find_user params[:user_id]
    @user_enroll_event =
      UserEnrollEvent.find_by event_id: user_event, user_id: user.id
  end

  def create_user_event_requirement
    user_event.requirement_details.ids.each do |event_requirement_id|
      current_user.requirements.create event_requirement_id: event_requirement_id
    end
  end

  def user_enroll_event_params
    params.require(:user_enroll_event).permit :status
  end

  def rescue_conversation
    participants = user_event.participants.reject {|p| p == user_event.leader}
    @user_event.participants = participants << user_event.leader
    return @conversation = Conversation.new unless participants.size > Settings.model.event.minimum_participant
    find_conversation current_user, user_event.participants.where
      .not(id: current_user)[0]
  end
end

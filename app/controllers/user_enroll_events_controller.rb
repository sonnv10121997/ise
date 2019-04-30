class UserEnrollEventsController < ApplicationController
  attr_reader :user_event, :user_enroll_event, :user, :conversation

  before_action ->{find_user params[:user_id]}, only: :create
  before_action ->{find_user_event params[:event_id]}, except: :index
  before_action :rescue_conversation, :update_user_event_requirement, only: :show
  before_action :find_user_enroll_event, only: %i(update destroy)

  def index
    @user_events = Event.participate_by current_user
  end

  def show; end

  def create
    current_user.user_enroll_events.create event_id: user_event.id
    create_user_event_requirement
    find_conversation user, user_event.leader
    ParticipantBroadcastJob.perform_now \
      user_event, user, "create", conversation.recipient(user)
  end

  def update
    user_enroll_event.update_attributes user_enroll_event_params
    update_joined_participants
    ParticipantBroadcastJob.perform_now user_event, user, "update"
  end

  def destroy
    user_enroll_event.destroy
    destroy_user_event_requirement
    update_joined_participants
    ParticipantBroadcastJob.perform_now \
      user_event, user, "delete", {}, event_path(user_event.slug)
  end

  private

  def find_user_enroll_event
    find_user params[:user_id]
    @user_enroll_event =
      UserEnrollEvent.find_by event_id: user_event, user_id: user
  end

  def create_user_event_requirement
    user_event.requirement_details.ids.each do |event_requirement_id|
      current_user.requirements.create event_requirement_id: event_requirement_id
    end
  end

  def destroy_user_event_requirement
    user_event.requirement_details.ids.each do |event_requirement_id|
      UserEventRequirement.find_by(user_id: user,
        event_requirement_id: event_requirement_id).destroy
    end
  end

  def update_user_event_requirement
    return unless conversation.persisted?
    user = current_user.Student? ? current_user : conversation.recipient(current_user)
    event_req = user_event.requirement_detail_ids
    user_req = user.event_requirements.where(event_id: user_event).ids
    missing_req = event_req - user_req
    missing_req.each do |event_requirement_id|
      user.requirements.create event_requirement_id: event_requirement_id
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

  def update_joined_participants
    joined_participants = user_event.participant_details
      .where(status: UserEnrollEvent.statuses.values[1]).size
    user_event.update_attributes joined_participants: joined_participants
  end
end

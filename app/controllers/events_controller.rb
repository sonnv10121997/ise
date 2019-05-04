class EventsController < ApplicationController
  attr_reader :filter, :events

  before_action :add_leader_to_events, only: :index
  before_action :check_administrator, only: :index
  before_action ->{find_event params[:id]}, only: :show

  def index
    @filter = params[:filter]
    @events = (filter ? Event.try(filter) : Event.publish).page(params[:page])
      .per Settings.model.event.per_page
  end

  def show; end

  private

  def add_leader_to_events
    Event.all.each do |event|
      event.participants << event.leader unless event.participants.any? {|p| p == event.leader}
      UserEnrollEvent.find_by(event_id: event, user_id: event.leader)
        .update_attributes status: UserEnrollEvent.statuses.values.last
    end
  end

  def check_administrator
    redirect_to rails_admin_path if current_user.Admin?
  end
end

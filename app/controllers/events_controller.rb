class EventsController < ApplicationController
  attr_reader :filter, :events

  before_action :add_leader_to_events, only: :index
  before_action :check_administrator, only: :index
  before_action ->{find_event params[:id]}, only: :show

  def index
    @filter = params[:filter]
    @events = (filter ? Event.try(filter) : Event.publishes).page(params[:page])
      .per Settings.model.event.per_page
  end

  def show; end

  private

  def add_leader_to_events
    Event.all.each do |event|
      next if event.participants.any? {|p| p == event.leader}
      event.participants << event.leader
    end
  end

  def check_administrator
    redirect_to rails_admin_path if current_user.Admin?
  end
end

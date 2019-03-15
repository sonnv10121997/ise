class EventsController < ApplicationController
  before_action :find_event, only: %i(show)

  def index
    @events = Event.all
  end

  def show; end

  private

  def find_event
    @event = Event.find_by id: params[:id]
  end
end

class EventsController < ApplicationController
  before_action :find_event, only: %i(show)

  def index
    @events = Event.page(params[:page]).per Settings.model.event.per_page
  end

  def show; end

  private

  def find_event
    @event = Event.find_by id: params[:id]
  end
end

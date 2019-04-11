class EventsController < ApplicationController
  attr_reader :filter, :events

  before_action ->{find_event params[:id]}, only: :show

  def index
    @filter = params[:filter]

    return @events = Event.where(status: [Event.statuses.keys[1], Event.statuses.keys[2]])
      .page(params[:page]).per(Settings.model.event.per_page) unless filter
    @events = Event.try(filter).page(params[:page]).per Settings.model.event.per_page
  end

  def show; end
end

class EventsController < ApplicationController
  before_action :find_event, only: :show

  def index
    @events = Event.page(params[:page]).per Settings.model.event.per_page
  end

  def show; end
end

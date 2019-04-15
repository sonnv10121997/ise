class SearchesController < ApplicationController
  def index
    q = params[:q]
    events = Event.ransack(name_cont_all: q).result distinct: true
    partners = Partner.ransack(name_cont_all: q).result distinct: true
    @items = events + partners
    @search_string = q
  end
end

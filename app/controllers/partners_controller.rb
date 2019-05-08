class PartnersController < ApplicationController
  before_action :find_partner

  def show; end

  private

  def find_partner
    @partner = Partner.find_by slug: params[:id]
  end
end

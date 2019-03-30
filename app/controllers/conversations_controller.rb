class ConversationsController < ApplicationController
  attr_reader :sender, :receiver

  before_action :find_sender, :find_receiver
  before_action ->{find_conversation sender, receiver}

  def create; end

  private

  def find_sender
    @sender = find_user params[:sender_id]
  end

  def find_receiver
    @receiver = find_user params[:receiver_id]
  end
end

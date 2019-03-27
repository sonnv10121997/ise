class ConversationsController < ApplicationController
  attr_reader :sender, :receiver

  before_action :find_sender, :find_receiver
  before_action :find_conversation_between_sender_and_receiver

  def create; end

  private

  def find_conversation_between_sender_and_receiver
    @conversation =
      Conversation.between(sender, receiver).first ||
      Conversation.create(conversation_params)
  end

  def conversation_params
    {sender_id: sender.id, receiver_id: receiver.id}
  end

  def find_sender
    @sender = find_user params[:sender_id]
  end

  def find_receiver
    @receiver = find_user params[:receiver_id]
  end
end

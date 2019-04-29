class ConversationsController < ApplicationController
  attr_reader :sender, :receiver

  before_action :find_sender, :find_receiver, except: :update
  before_action ->{find_user_event params[:event_slug]}, except: :update
  before_action ->{find_conversation sender, receiver}, except: :update
  skip_authorize_resource only: :update
  authorize_resource

  def create; end

  def update
    @new_message = Message.new message_params
  end

  private

  def find_sender
    @sender = find_user params[:sender_id]
  end

  def find_receiver
    @receiver = find_user params[:receiver_id]
  end

  def message_params
    params.require(:message).permit :id, :user_id, :conversation_id, :content,
      :read, :created_at, :updated_at
  end
end

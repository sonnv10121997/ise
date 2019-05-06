class MessagesController < ApplicationController
  attr_reader :conversation, :message, :event

  before_action ->{find_event params[:event_id]}
  before_action :find_conversation
  before_action :find_message
  authorize_resource

  def create
    conversation.messages.not_read_by(current_user).update_all read: true
    @message = conversation.messages.new message_params
    @message.user = current_user
    @message.save
    CreateMessageBroadcastJob.perform_now event, message
    create_notification nil, nil, message, current_user,
      conversation.recipient(current_user), Notification.types.values[8], "info"
  end

  def destroy
    message.destroy
    DestroyMessageBroadcastJob.perform_now event, message
    create_notification nil, nil, nil, current_user,
      conversation.recipient(current_user), Notification.types.values[9], "info"
  end

  private

  def find_conversation
    @conversation = Conversation.find_by id: params[:conversation_id]
  end

  def find_message
    @message = conversation.messages.find_by id: params[:id]
  end

  def message_params
    params.require(:message).permit :content
  end
end

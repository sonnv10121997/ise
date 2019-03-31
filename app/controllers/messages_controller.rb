class MessagesController < ApplicationController
  attr_reader :conversation, :message

  before_action :find_conversation
  before_action :find_message
  authorize_resource

  def create
    conversation.messages.not_read_by(current_user).update_all read: true
    @message = conversation.messages.new message_params
    @message.user = current_user
    @message.save
    respond_to do |format|
      format.js {render "conversations/create", conversation: conversation,
        message: message}
    end
  end

  def destroy
    message.destroy
    respond_to do |format|
      format.js {render "conversations/create", conversation: conversation,
        message: message}
    end
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

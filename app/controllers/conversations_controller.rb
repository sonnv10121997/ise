class ConversationsController < ApplicationController
  def create
    if Conversation.between(params[:sender_id], params[:receiver_id]).present?
      @conversation =
        Conversation.between(params[:sender_id], params[:receiver_id]).first
    else
      @conversation = Conversation.create conversation_params
    end
    respond_to :js
  end

  private

  def conversation_params
    params.permit :sender_id, :receiver_id
  end
end

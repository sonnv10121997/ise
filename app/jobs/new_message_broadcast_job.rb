class NewMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform message
    ActionCable.server.broadcast \
      "conversation:#{message.conversation_id}:messages:create",
      message: render_message(message)
  end

  private

  def render_message message
    MessagesController.render json: message
  end
end

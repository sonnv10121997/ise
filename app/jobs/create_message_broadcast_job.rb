class CreateMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform message
    ActionCable.server.broadcast \
      "conversation:#{message.conversation_id}:messages:create",
      message: render_message(message), method: "create"
  end

  private

  def render_message message
    MessagesController.render partial: "messages/message",
      locals: {message: message}
  end
end

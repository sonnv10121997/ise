class CreateMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform message
    ActionCable.server.broadcast \
      "conversation:#{message.conversation_id}:messages:create",
      message: render_message(message)
  end

  private

  def render_message message
    hash_message = JSON.parse MessagesController.render(json: message)
    hash_message["method"] = "create"
    hash_message
  end
end

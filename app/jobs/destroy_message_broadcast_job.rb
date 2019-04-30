class DestroyMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform event, message
    ActionCable.server.broadcast "conversations:#{message.conversation_id}",
      method: "destroy", message: {id: message.id, user_id: message.user_id}
  end
end

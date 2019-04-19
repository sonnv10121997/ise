class DestroyMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform message
    ActionCable.server.broadcast \
      "conversation:#{message.conversation_id}:messages:destroy",
      message: {id: message.id, user_id: message.user_id, method: "destroy"}
  end
end

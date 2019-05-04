class DestroyMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform event, message
    ActionCable.server.broadcast "events:#{event.id}:conversations",
      method: "destroy", message: {id: message.id, user_id: message.user_id},
      conversation_id: message.conversation_id
  end
end

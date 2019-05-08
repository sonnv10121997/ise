class DestroyMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform event, message, sender
    recipient = message.conversation.recipient(sender)
    ActionCable.server.broadcast "events:#{event.id}:conversations",
      method: "destroy", message: {id: message.id, user_id: message.user_id,
      unread: message.conversation.unread_messages(recipient).size,
      receiver_id: recipient.id}, conversation_id: message.conversation_id
  end
end

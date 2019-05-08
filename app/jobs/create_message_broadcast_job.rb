class CreateMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform event, message, sender
    recipient = message.conversation.recipient(sender)
    ActionCable.server.broadcast "events:#{event.id}:conversations",
      method: "create", message: {html: render_message(event, message),
      user_id: message.user_id, unread: message.conversation
      .unread_messages(recipient).size, receiver_id: recipient.id},
      conversation_id: message.conversation_id
  end

  private

  def render_message event, message
    MessagesController.render partial: "messages/message",
      locals: {message: message, event: event}
  end
end

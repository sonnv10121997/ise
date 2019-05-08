module ConversationsHelper
  def rescue_unread_message conversation, current_user
    return if conversation.unread_messages(current_user).empty?
    conversation.unread_messages(current_user).size
  end

  def rescue_conversation sender, receiver
    Conversation.between(sender, receiver).first ||
      Conversation.create(sender_id: sender.id, receiver_id: receiver.id)
  end
end

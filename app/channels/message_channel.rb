class MessageChannel < ApplicationCable::Channel
  def listen_create_message data
    stream_from "conversation:#{data["conversation_id"]}:messages:create"
  end

  def listen_destroy_message data
    stream_from "conversation:#{data["conversation_id"]}:messages:destroy"
  end
end

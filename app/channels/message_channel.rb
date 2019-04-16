class MessageChannel < ApplicationCable::Channel
  def listen_new_message data
    stream_from "conversation:#{data["conversation_id"]}:messages:create"
  end
end

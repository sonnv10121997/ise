class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversations:#{params[:conversation_id]}"
  end
end

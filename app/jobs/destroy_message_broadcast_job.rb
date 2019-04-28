class DestroyMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform event, message
    ActionCable.server.broadcast "events:#{event.id}", method: "destroy",
      message: {id: message.id, user_id: message.user_id}
  end
end

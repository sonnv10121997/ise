class RequirementChannel < ApplicationCable::Channel
  def subscribed
    stream_from "events:#{params[:event_id]}:user:#{params[:user_id]}"
  end
end

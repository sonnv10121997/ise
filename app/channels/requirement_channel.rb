class RequirementChannel < ApplicationCable::Channel
  def subscribed
    stream_from "events:#{params[:event_id]}"
  end
end

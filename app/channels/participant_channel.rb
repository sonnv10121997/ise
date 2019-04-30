class ParticipantChannel < ApplicationCable::Channel
  def subscribed
    stream_from "events:#{params[:event_id]}:participants"
  end
end

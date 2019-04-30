class ParticipantBroadcastJob < ApplicationJob
  queue_as :default

  def perform event, user, url, method
    if method == "update"
      ActionCable.server.broadcast "events:#{event.id}:participants",
        enroll_request: {html: render_enroll_request(event, user)},
        event_participants: {html: render_event_participants(event)},
        user_id: user.id, method: method
    elsif method == "delete"
      ActionCable.server.broadcast "events:#{event.id}:participants",
        url: url, method: method, user_id: user.id
    end
  end

  private

  def render_enroll_request event, user
    ApplicationController.render partial: "events/enroll_request",
      locals: {user: user, event: event}
  end

  def render_event_participants event
    ApplicationController.render partial: "user_enroll_events/event_participants",
      locals: {event: event}
  end
end

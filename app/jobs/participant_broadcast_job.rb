class ParticipantBroadcastJob < ApplicationJob
  queue_as :default

  def perform event, user, method, sender = nil, url = nil
    channel = "events:#{event.id}:participants"

    case method
    when "create"
      ActionCable.server.broadcast channel, method: method,
        participant: {html: render_participant(event, user, sender)}
    when "update"
      ActionCable.server.broadcast channel, user_id: user.id, method: method,
        enroll_request: {html: render_enroll_request(event, user)},
        event_participants: {html: render_event_participants(event)},
        participant: {html: render_participant(event, user, sender)}
    when "delete_from_leader"
      ActionCable.server.broadcast channel, method: method, user_id: user.id,
        url: url
    when "delete_from_student"
      ActionCable.server.broadcast channel, method: method, user_id: user.id,
        event_participants: {html: render_event_participants(event)}, url: url
    end
  end

  private

  def render_participant event, user, sender
    ApplicationController.render partial: "user_enroll_events/participant",
      locals: {user: user, user_event: event, sender: sender}
  end

  def render_enroll_request event, user
    ApplicationController.render partial: "events/enroll_request",
      locals: {user: user, event: event}
  end

  def render_event_participants event
    ApplicationController.render partial: "user_enroll_events/event_participants",
      locals: {event: event}
  end
end

module ParticipantsHelper
  def is_enrolled? user, event
    user.check_enroll_status(event) == UserEnrollEvent.statuses.keys[1]
  end

  def is_enrolling? user, event
    user.check_enroll_status(event) == UserEnrollEvent.statuses.keys[0]
  end

  def rescue_participant_css index
    return "active" if index&.zero?
  end
end

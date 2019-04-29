module ParticipantsHelper
  def is_enrolled? user, event
    user.check_enroll_status(event) == UserEnrollEvent.statuses.keys[1]
  end
end

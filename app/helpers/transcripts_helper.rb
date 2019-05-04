module TranscriptsHelper
  def rescue_transcript event, conversation
    return current_user.transcript_by_event event if current_user.Student?
    conversation.recipient(current_user).transcript_by_event event
  end

  def rescue_transcript_css total
    return "btn btn-success button-text" if total > Settings.model.transcript.pass_mark
    "btn btn-danger button-text"
  end

  def rescue_transcript_status total
    return "passed" if total > Settings.model.transcript.pass_mark
    "failed"
  end
end

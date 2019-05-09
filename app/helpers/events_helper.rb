module EventsHelper
  def rescue_title title
    return title unless title.length >= Settings.model.event.max_title_length
    title.first(Settings.model.event.max_title_length) << "..."
  end

  def event_major_acronym event
    event.majors.first&.acronym
  end

  def event_major_name event
    event.majors.first&.name
  end

  def event_date event
    "#{event.start_date.strftime Settings.model.event.date_format} - " <<
      "#{event.end_date.strftime Settings.model.event.date_format}"
  end

  def event_participants event
    "#{event.joined_participants}/#{event.max_participants}"
  end

  def number_to_vnd number
    number_to_currency number, locale: session[:locale],
      format: Settings.application.currency.vnd.format,
      unit: Settings.application.currency.vnd.unit,
      precision: Settings.application.currency.vnd.precision
  end

  def rescue_status current_status
    case current_status
    when Event.statuses.keys[0]
      "danger"
    when Event.statuses.keys[1]
      "success"
    when Event.statuses.keys[2]
      "primary"
    when Event.statuses.keys[3]
      "warning"
    when Event.statuses.keys[4]
      "secondary"
    end
  end

  def rescue_enroll_status current_status
    case current_status
    when UserEnrollEvent.statuses.keys[0]
      "btn btn-warning button-text"
    when UserEnrollEvent.statuses.keys[1]
      "btn btn-success button-text"
    else
      "btn button-text-default"
    end
  end

  def rescue_publish_status status
    return "button button-text tab" if status == Event.statuses.values[1]
    "btn button-text-default tab"
  end

  def rescue_active_panel status
    return "active" if status == Event.statuses.values[1]
  end

  def rescue_padding filter
    return "pb-100" if Settings.model.event.sorted_by.keys.last == filter
  end

  def enrollable? event, user
    return true if event.status == Event.statuses.keys[1] && user.Student?
    false
  end

  def publish_status? key
    current_user.Student? && key == Event.statuses.keys[1]
  end
end

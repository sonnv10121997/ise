module EventsHelper
  def event_major_acronym event
    event.majors.first ? event.majors.first.acronym : ""
  end

  def event_date event
    "#{event.start_date.strftime "%d/%m/%y"} - #{event.end_date.strftime "%d/%m/%y"}"
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
end

module MessagesHelper
  def format_message_time message
    message.created_at.strftime "#{Settings.model.message.date_format} #{t ".at"}
      #{Settings.model.message.time_format}"
  end
end

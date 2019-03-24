class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :content, :conversation, :user

  private

  def time at
    created_at.strftime "#{Settings.model.message.date_format} #{at}
      #{Settings.model.message.time_format}"
  end
end

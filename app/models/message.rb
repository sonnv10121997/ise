class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  after_create :broadcast_new_message

  validates_presence_of :content, :conversation, :user

  scope :not_read_by, ->(user) {where.not user: user, read: true}

  private

  def broadcast_new_message
    NewMessageBroadcastJob.perform_now self
  end
end

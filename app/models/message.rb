class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  after_create :broadcast_create_message
  after_destroy :broadcast_destroy_message

  validates_presence_of :content, :conversation, :user

  scope :not_read_by, ->(user) {where.not user: user, read: true}

  private

  def broadcast_create_message
    CreateMessageBroadcastJob.perform_now self
  end

  def broadcast_destroy_message
    DestroyMessageBroadcastJob.perform_now self
  end
end

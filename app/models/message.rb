class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  has_one :notification, dependent: :destroy

  validates_presence_of :content, :conversation, :user

  scope :not_read_by, ->(user) {where.not user: user, read: true}
end

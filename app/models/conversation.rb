class Conversation < ApplicationRecord
  belongs_to :sender, class_name: User.name, foreign_key: :sender_id
  belongs_to :receiver, class_name: User.name, foreign_key: :receiver_id

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender, scope: :receiver

  scope :between, (lambda do |sender, receiver|
    where sender: [sender, receiver], receiver: [sender, receiver]
  end)

  def recipient current_user
    sender == current_user ? receiver : sender
  end

  def unread_messages current_user
    messages.where "user_id != ? AND `read` = ?", current_user, false
  end
end

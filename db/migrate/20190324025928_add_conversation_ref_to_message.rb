class AddConversationRefToMessage < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :conversation, foreign_key: true
  end
end

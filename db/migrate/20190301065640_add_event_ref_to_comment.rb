class AddEventRefToComment < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :event, foreign_key: true
  end
end

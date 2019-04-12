class AddPartnerRefToEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :partner, foreign_key: true, null: false
  end
end

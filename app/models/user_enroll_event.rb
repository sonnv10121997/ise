class UserEnrollEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event, inverse_of: :participant_details

  delegate :name, to: :user, allow_nil: true
end

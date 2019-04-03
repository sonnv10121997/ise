class UserEnrollEvent < ApplicationRecord
  enum status: %i(unenrolled enrolled ongoing finished)

  belongs_to :user
  belongs_to :event, inverse_of: :participant_details

  delegate :name, to: :user, allow_nil: true
end

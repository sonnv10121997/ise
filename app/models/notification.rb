class Notification < ApplicationRecord
  NOTIFICATION_TYPES = %i(new_enroll new_unenroll unapprove_enroll approve_enroll
    remove_enroll update_requirement approve_requirement unapprove_requirement
    new_message delete_message)

  enum type: NOTIFICATION_TYPES

  belongs_to :event
  belongs_to :receiver
  belongs_to :notifier
  belongs_to :requirement
  belongs_to :message
end

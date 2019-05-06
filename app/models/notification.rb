class Notification < ApplicationRecord
  NOTIFICATION_TYPES = %i(new_enroll new_unenroll unapprove_enroll approve_enroll
    remove_enroll update_requirement approve_requirement unapprove_requirement
    new_message delete_message)

  enum type: NOTIFICATION_TYPES

  belongs_to :notifier, class_name: User.name, foreign_key: :notifier_id
  belongs_to :receiver, class_name: User.name, foreign_key: :receiver_id
  belongs_to :event, optional: true
  belongs_to :requirement, optional: true
  belongs_to :message, optional: true

  delegate :name, to: :notifier, prefix: true, allow_nil: true
  delegate :name, to: :event, prefix: true, allow_nil: true
  delegate :name, to: :requirement, prefix: true, allow_nil: true
  delegate :content, to: :message, prefix: true, allow_nil: true
end

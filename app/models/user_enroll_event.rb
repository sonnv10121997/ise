class UserEnrollEvent < ApplicationRecord
  belongs_to :participant, class_name: User.name, foreign_key: :user_id
  belongs_to :enroll, class_name: Event.name, foreign_key: :event_id
end

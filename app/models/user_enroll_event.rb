class UserEnrollEvent < ApplicationRecord
  belongs_to :user
  belongs_to :enroll, class_name: Event.name, foreign_key: :event_id
end

class UserLeadEvent < ApplicationRecord
  belongs_to :leader, class_name: User.name,
    foreign_key: :user_id
  belongs_to :event
end

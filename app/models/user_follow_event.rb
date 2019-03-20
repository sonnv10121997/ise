class UserFollowEvent < ApplicationRecord
  belongs_to :user
  belongs_to :followings, foreign_key: :event_id, class_name: Event.name
end

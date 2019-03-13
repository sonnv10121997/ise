class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :parent, class_name: Comment.name, optional: true

  validates_presence_of :content
end

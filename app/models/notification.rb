class Notification < ApplicationRecord
  belongs_to :event
  belongs_to :receiver
  belongs_to :notifier
end

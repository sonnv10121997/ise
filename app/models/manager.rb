class Manager < User
  include FriendlyId
  friendly_id :name, use: :slugged
end

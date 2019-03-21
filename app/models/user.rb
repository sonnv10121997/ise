class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :confirmable, :omniauthable, omniauth_providers: %i(google_oauth2)

  enum gender: %i(male female)
  enum type: {Admin: Admin.name, Manager: Manager.name,
    Staff: Staff.name, Student: Student.name}

  has_many :user_follow_events
  has_many :followings, through: :user_follow_events

  validates_length_of :name,
    maximum: Settings.model.user.max_name_length,
    minimum: Settings.model.user.min_name_length
  validates_presence_of :gender
  validates_presence_of :dob
  validates_presence_of :code
  validates_numericality_of :phone
end

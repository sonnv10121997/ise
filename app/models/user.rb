class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :confirmable, :omniauthable, omniauth_providers: %i(google_oauth2)

  enum gender: %i(male female)
  enum type: {Admin: Admin.name, Manager: Manager.name,
    Staff: Staff.name, Student: Student.name}

  ROLL_NUMBER_FORMAT = /((SB|SE)[0-9]{5}|(HA|HE)[0-9]{6})/

  has_many :user_enroll_events
  has_many :enrolls, through: :user_enroll_events
  has_one :avatar, as: :imageable, dependent: :destroy, class_name: Image.name

  accepts_nested_attributes_for :avatar, allow_destroy: true,
    reject_if: proc {|attributes| attributes["file"].blank?}

  validates_presence_of :name, :email, :code, :gender, :dob, :phone
  validates_uniqueness_of :name, :email, :code

  validates :name,
    length: {maximum: Settings.model.user.max_name_length, minimum: Settings.model.user.min_name_length}
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :phone, numericality: true,
    length: {maximum: Settings.model.user.phone_number.maximum,
      minimum: Settings.model.user.phone_number.minimum}
  validates :code, format: {with: ROLL_NUMBER_FORMAT}
end

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :confirmable, :omniauthable, omniauth_providers: %i(google_oauth2)
  validates :name, presence: true, length: { maximum: Settings.model.user.max_name_length }
  validates :gender, presence: true, inclusion: {in: %i(male female)}
  validates :dob, presence: true
  validates :code, presence: true
  validates :phone, presence: true, format: { without: /\D/ }
end

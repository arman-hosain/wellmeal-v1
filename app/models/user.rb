
class User < ApplicationRecord
  has_many :preferences
  has_many :menus
  has_one :review, through: :menus
  has_many :meal_attendances
  has_many :notices

  enum role: { user: 0, admin: 1 }
  validates :email, :phone, :role, presence: true
  validates :first_name, :last_name, presence: true, format: { with: /\A[A-Za-z]+\z/ }
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_plausible_phone :phone, presence: true
end

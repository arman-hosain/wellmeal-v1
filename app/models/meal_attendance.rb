
class MealAttendance < ApplicationRecord
  belongs_to :user

  enum meal_type: { lunch: 0, snack: 1 }
  validates :meal_date, presence: true
  validate :meal_date_cannot_be_past


  private

  def meal_date_cannot_be_past
    if meal_date.present? && meal_date < Date.today
      errors.add(:meal_date, "cannot be a past date")
    end
  end

end

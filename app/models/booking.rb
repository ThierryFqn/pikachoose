class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon

  BOOKING_STATUS = %w[accepted denied cancelled pending]

  validates :begin_date, presence: true
  validates :end_date, presence: true
  validates :total_price, presence: true
  validates :status, presence: true, defautl: Booking::BOOKING_STATUS[3]
end

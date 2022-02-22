class Pokemon < ApplicationRecord
  # const
  POKEMON_TYPES = %w[bug dragon fairy fire ghost ground normal psychic steel dark electric fighting flying grass ice poison rock water]
  POKEMON_GENDERS = %w[male female asexual]
  POKEMON_PERSONALITIES = %w[brave calm quiet docile rash gentle careful relaxing timid athlete smart]
  belongs_to :user
  # ActiveStorage Cloudinary
  has_one_attached :photo

  has_many :bookings, dependent: :destroy
  # Validates
  validates :name, :day_price, :gender, :element, :personality, presence: true
  validates :element, inclusion: { in: POKEMON_TYPES, message: "Please select a type from the list" }
  validates :gender, inclusion: { in: POKEMON_GENDERS, message: "Please select a valid gender" }
  validates :personality, inclusion: { in: POKEMON_PERSONALITIES, message: "Please select a valid personality" }
  validates :height, :weight, numericality: { greater_than: 0 }
  validates :day_price, numericality: { only_integer: true }
end

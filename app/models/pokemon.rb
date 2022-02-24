class Pokemon < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  # const
  POKEMON_TYPES = %w[bug dragon fairy fire ghost ground normal psychic steel dark electric fighting flying grass ice poison rock water]
  POKEMON_GENDERS = %w[male female asexual]
  POKEMON_PERSONALITIES = %w[brave calm quiet docile rash gentle careful relaxing timid athlete smart]
  POKEMON_STREET = ["rue de l'eglise", "Place de l'eglise", "Grande Rue", "Rue du Moulin", "Place de la Mairie", "Rue du Château", "Rue des Écoles", "Rue de la Gare", "Rue de la Mairie", "rue principale"]
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

# api_key_mel=pk.eyJ1IjoibWVsaXNzYWdhdGVhdTEiLCJhIjoiY2t6aDBja2V3MTYxZzJubnkwMDYxcHhoMSJ9.nMF_YE0lIzoIGLyL_lQLHg

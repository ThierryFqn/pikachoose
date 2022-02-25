class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Active Storage
  has_one_attached :photo

  has_many :pokemons, dependent: :destroy
  has_many :bookings, dependent: :destroy
  # Validates
  validates :first_name, :last_name, presence: true

  before_save :attach_photo
  def attach_photo
    return if photo.attached?
    self.photo.attach(io: File.open(File.join(Rails.root,'app/assets/images/sacha.jpeg')), filename: 'Sacha')
  end
end

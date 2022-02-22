class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Active Storage
  has_one_attached :photo

  has_many :pokemons, dependent: :destroy
  # Validates
  validates :first_name, :last_name, presence: true
end

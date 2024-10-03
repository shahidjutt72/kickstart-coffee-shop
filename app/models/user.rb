class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy

  # Devise for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true

  after_create :create_cart

  private

  def create_cart
    create_cart!
  end
end

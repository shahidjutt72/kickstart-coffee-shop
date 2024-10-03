class Product < ApplicationRecord
  has_many :order_items
  has_many :tax_rates
  has_many :discount_group_products
  has_many :discount_groups, through: :discount_group_products
  has_many :cart_items, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :name, :price, presence: true
end

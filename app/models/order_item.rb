class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product_id, :order_id, :quantity, :subtotal, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end

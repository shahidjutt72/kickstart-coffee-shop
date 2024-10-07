class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def subtotal
  	product.price.to_f * quantity.to_f
  end
end

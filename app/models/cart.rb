class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def clear_cart
    cart_items.destroy_all
  end
end

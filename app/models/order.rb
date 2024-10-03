class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: { pending: 0, completed: 1 }

  validates :user_id, :subtotal, :total, presence: true

  # Method to check if the order includes a specific product
  def includes_product?(product)
    order_items.exists?(product_id: product.id)
  end

  # Method to calculate subtotal for a specific group of products
  def subtotal_for_group(group)
    group.products.map do |product|
      order_items.find_by(product_id: product.id).subtotal
    end.sum
  end
end

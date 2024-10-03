class DiscountGroup < ApplicationRecord
  belongs_to :discount
  has_many :discount_group_products
  has_many :products, through: :discount_group_products

  # Check if the order is eligible for a discount based on this group
  def eligible_for_discount?(order)
    # The group is eligible if all products in the group are present in the order
    products.all? { |product| order.includes_product?(product) }
  end
end

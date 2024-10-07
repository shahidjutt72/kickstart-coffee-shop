class Discount < ApplicationRecord
  has_one :discount_group, dependent: :destroy
  accepts_nested_attributes_for :discount_group, allow_destroy: true

  validates :rate, :discount_type, presence: true
  validates :rate, numericality: { greater_than_or_equal_to: 0 }

  enum discount_type: {
    flat: 0,
    percentage: 1
  }

  # Methods to calculate discount
  def apply_discount(order)
    discount = 0
    discount += calculate_discount(order) if discount_group.eligible_for_discount?(order)
    discount
  end

  private

  def calculate_discount(order)
    # Logic to calculate discount based on discount type
    if percentage?
      order.subtotal_for_group(discount_group) * (rate / 100)
    else
      rate
    end
  end
end

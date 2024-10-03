class Discount < ApplicationRecord
  has_many :discount_groups, dependent: :destroy

  validates :rate, :discount_type, presence: true
  validates :rate, numericality: { greater_than_or_equal_to: 0 }

  enum discount_type: {
    flat: 0,
    percentage: 1
  }

  # Methods to calculate discount
  def apply_discount(order)
    discount = 0
    discount_groups.each do |group|
      discount += calculate_discount(order, group) if group.eligible_for_discount?(order)
    end
    discount
  end

  private

  def calculate_discount(order, group)
    # Logic to calculate discount based on discount type
    if percentage?
      order.subtotal_for_group(group) * (rate / 100)
    else
      rate
    end
  end
end

class Orders::Calculator
  def initialize(order)
    @order = order
  end

  attr_reader :order

  def calculate
    subtotal = order.order_items.sum(&:subtotal)

    # Apply discounts based on eligible product combinations (groups)
    discount = apply_combination_discount

    # Calculate taxes
    total_tax = calculate_tax

    # Final total
    total = subtotal - discount + total_tax

    # Update order with calculated values
    order.attributes = { subtotal: subtotal, total: total, total_tax: total_tax, total_discount: discount }
  end

  private

  def apply_combination_discount
    discount = 0

    Discount.all.each do |discount_rule|
      discount += discount_rule.apply_discount(order)
    end

    discount
  end

  def calculate_tax
    total_tax = 0

    order.order_items.each do |item|
      product = item.product

      product.tax_rates.each do |tax_rate|
        if tax_rate.percentage?
          item_tax = (item.subtotal * tax_rate.rate) / 100.0
        elsif tax_rate.flat?
          item_tax = tax_rate.rate
        end

        total_tax += item_tax
      end
    end

    total_tax
  end
end

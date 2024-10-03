class TaxRate < ApplicationRecord
  belongs_to :product

  validates :rate, :tax_type, :product_id, presence: true
  validates :rate, numericality: { greater_than_or_equal_to: 0 }

  enum tax_type: {
    flat: 0,
    percentage: 1
  }
end

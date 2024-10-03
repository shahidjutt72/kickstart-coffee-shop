class DiscountGroupProduct < ApplicationRecord
  belongs_to :discount_group
  belongs_to :product
end

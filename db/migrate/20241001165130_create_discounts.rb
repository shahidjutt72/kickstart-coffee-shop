class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.decimal :rate, default: 0
      t.integer :discount_type

      t.timestamps
    end
  end
end

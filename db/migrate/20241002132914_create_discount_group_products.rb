class CreateDiscountGroupProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :discount_group_products do |t|
      t.integer :discount_group_id
      t.integer :product_id

      t.timestamps
    end
  end
end

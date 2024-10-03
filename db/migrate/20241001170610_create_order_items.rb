class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity
      t.decimal :subtotal, default: 0
      t.decimal :total_tax, default: 0
      t.decimal :total, default: 0

      t.timestamps
    end
  end
end

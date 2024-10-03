class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.decimal :subtotal, default: 0
      t.decimal :total, default: 0
      t.string :order_number
      t.integer :status
      t.decimal :total_tax, default: 0
      t.decimal :total_discount, default: 0

      t.timestamps
    end
  end
end

class AddColumnAddressToOrders < ActiveRecord::Migration[6.1]
  def change
  	add_column :orders, :address, :string
  	add_column :orders, :payment_method, :string
  end
end

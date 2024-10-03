class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :product_type
      t.string :image
      t.decimal :price, default: 0

      t.timestamps
    end
  end
end

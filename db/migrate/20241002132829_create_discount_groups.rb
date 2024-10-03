class CreateDiscountGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :discount_groups do |t|
      t.integer :discount_id

      t.timestamps
    end
  end
end

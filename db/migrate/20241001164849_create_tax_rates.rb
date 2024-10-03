class CreateTaxRates < ActiveRecord::Migration[6.1]
  def change
    create_table :tax_rates do |t|
      t.decimal :rate, default: 0
      t.integer :product_id
      t.integer :tax_type

      t.timestamps
    end
  end
end

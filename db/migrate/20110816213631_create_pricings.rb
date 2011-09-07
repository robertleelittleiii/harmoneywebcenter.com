class CreatePricings < ActiveRecord::Migration
  def self.up
    create_table :pricings do |t|
      t.integer :product_id
      t.float :purchase_price
      t.float :competitor_price
      t.float :contract_price

      t.timestamps
    end
  end

  def self.down
    drop_table :pricings
  end
end

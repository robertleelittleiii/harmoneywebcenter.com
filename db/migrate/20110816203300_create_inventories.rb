class CreateInventories < ActiveRecord::Migration
  def self.up
    create_table :inventories do |t|
      t.integer :product_id
      t.string :lot_no
      t.date :expiration_date
      t.integer :quantity_on_hand

      t.timestamps
    end
  end

  def self.down
    drop_table :inventories
  end
end

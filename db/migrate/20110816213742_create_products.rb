class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :vender_id
      t.string :name
      t.text :description
      t.string :ndc_no
      t.string :item_no

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end

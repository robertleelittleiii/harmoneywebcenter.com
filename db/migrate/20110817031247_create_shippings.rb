class CreateShippings < ActiveRecord::Migration
  def self.up
    create_table :shippings do |t|
      t.integer :packing_slip_no
      t.date :date_shipped
      t.string :shipped_via
      t.integer :weight
      t.float :cost

      t.timestamps
    end
  end

  def self.down
    drop_table :shippings
  end
end

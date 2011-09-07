class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.integer :user_id
      t.string :company_name
      t.string :billing_street_address
      t.string :billing_city
      t.string :billing_state
      t.string :billing_zip_code
      t.string :shipping_street_address
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip_code
      t.string :phone_number
      t.string :fax_number
      t.string :email_address
      t.string :contact_name

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end

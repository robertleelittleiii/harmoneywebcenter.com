class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_items
  has_many :shippings
  
end

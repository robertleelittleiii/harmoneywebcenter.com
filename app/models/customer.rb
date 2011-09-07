class Customer < ActiveRecord::Base
  
  has_many :orders
  belongs_to :user
  has_many :shippings
  
end

class Product < ActiveRecord::Base
  has_many :pricings
  has_many :inventories
  
  belongs_to :vendor
  
end

class Inventory < ActiveRecord::Base
  belongs_to :product
      validates :lot_no,
        :presence => {:message => "can't be blank"}
      validates :expiration_date,
        :presence => {:message => "can't be blank"}
      validates :quantity_on_hand,
        :presence => {:message => "can't be blank"}
   
  
  
  
  def date_is_ok
    unless self.expiration_date.to_datetime >=  Time.now.to_datetime
        errors.add :expiration_date, "must be in the future"
        return false
     end
     true
   end
end

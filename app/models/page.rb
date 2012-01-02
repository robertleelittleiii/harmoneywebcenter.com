class Page < ActiveRecord::Base
#  belongs_to :menu
  has_one :menu
  
  
  def name()
   return_name =   self.menu.nil? ? self.title : self.menu.name
   return return_name
  end
end

class UpdatePermissionsForTables2 < ActiveRecord::Migration
 def self.up
    
		#Admin role name should be "Admin" for convenience
    role_sales = Role.new
		role_sales.name = "Sales"
		role_sales.save

    role_shipping = Role.new
    role_shipping.name = "Shipping"
    role_shipping.save

    role_receiving = Role.new
    role_receiving.name = "Receiving"
    role_receiving.save

    role_manager = Role.new
    role_manager.name = "Manager"
    role_manager.save

    #Create all of the rights for all existing controllers for the admin
    #assign them to Admin role.
    role_admin =  Role.find_by_name('Admin')
    role_cust =  Role.find_by_name('Customer')
    role_siteowner =  Role.find_by_name('Site Owner')

    right = Right.create :name => "*Access to all shipping actions", :controller => "shippings", :action => "*"
    role_siteowner.rights << right
    role_admin.rights << right
    role_manager.rights << right
    role_sales.rights << right
    role_shipping.rights << right
    
   right = Right.create :name => "*Access to all customer actions", :controller => "customers", :action => "*"
    role_siteowner.rights << right
    role_admin.rights << right
    role_manager.rights << right
    role_sales.rights << right
    
    right = Right.create :name => "*Access to all vendor actions", :controller => "vendors", :action => "*"
    role_admin.rights << right
    role_siteowner.rights << right
    role_manager.rights << right
    role_receiving.rights << right
    
    right = Right.create :name => "*Access to all product actions", :controller => "products", :action => "*"
    role_admin.rights << right
    role_siteowner.rights << right
    role_manager.rights << right
    role_receiving.rights << right
    role_sales.rights << right
    role_shipping.rights << right

    right = Right.create :name => "*Access to all order actions", :controller => "orders", :action => "*"
    role_admin.rights << right
    role_siteowner.rights << right
    role_manager.rights << right
    role_sales.rights << right
    role_shipping.rights << right

    right = Right.create :name => "*Access to all order item actions", :controller => "order_items", :action => "*"
    role_admin.rights << right
    role_siteowner.rights << right
    role_manager.rights << right
    role_sales.rights << right
    role_shipping.rights << right

    right = Right.create :name => "*Access to all pricing actions", :controller => "pricings", :action => "*"
    role_admin.rights << right
    role_siteowner.rights << right
    role_manager.rights << right
    role_receiving.rights << right
    role_sales.rights << right
   
    right = Right.create :name => "*Access to all inventory actions", :controller => "inventories", :action => "*"
    role_admin.rights << right
    role_siteowner.rights << right
    role_manager.rights << right
    role_receiving.rights << right
    role_sales.rights << right

   right = Right.create :name => "*Access to all menu actions", :controller => "menus", :action => "*"
    role_admin.rights << right
    role_siteowner.rights << right
    
   right = Right.create :name => "*Access to all page actions", :controller => "pages", :action => "*"
    role_admin.rights << right
    role_siteowner.rights << right
    role_manager.rights << right
    
   
   right = Right.create :name => "*Access to all attachment actions", :controller => "attachments", :action => "*"
    role_admin.rights << right
    role_siteowner.rights << right
    role_manager.rights << right
    role_receiving.rights << right
    role_sales.rights << right
    role_shipping.rights << right
    
   right = Right.find_by_name("*Access to all admin actions")
    role_manager.rights << right
    role_receiving.rights << right
    role_sales.rights << right
    role_shipping.rights << right

    
    right = Right.find_by_name("*Access to all rights actions")

    right = Right.find_by_name("*Access to all roles actions")

    right = Right.find_by_name("*Access to all user actions")
    role_manager.rights << right

    right = Right.find_by_name("*Access to all login actions")
    role_manager.rights << right
    role_receiving.rights << right
    role_sales.rights << right
    role_shipping.rights << right
    
   
    role_siteowner.save
    role_cust.save
    role_admin.save 
    role_manager.save
    role_receiving.save
    role_sales.save
    role_shipping.save
    
  end

  def self.down
    #Get Admin User
    admin_user =  User.find_by_name('Admin@one.com')

    #Get Admin Role

		role_sales = Role.find_by_name("Sales")
  	role_shipping = Role.find_by_name("Shipping")
		role_receiving = Role.find_by_name("Receiving")
		role_manager = Role.find_by_name("Manager")
  

# Clear Admin user roles
# NOT NEEDED
#    admin_user.roles << []
#    admin_user.save

#Destroy Admin User - can't delete last user.
#    admin_user.destroy

 # Clear Admin role rights
 # NOT NEEDED
 #   admin_role.rights = []

    #Destroy Admin Role
    role_sales.destroy rescue puts("sales role not found.")
    role_shipping.destroy rescue puts("shipping role not found.")
    role_receiving.destroy rescue puts("receiving role not found.")
    role_manager.destroy rescue puts("manager role not found.")

    #Destroy all rights    
    right = Right.find_by_name("*Access to all customer actions")
    right.destroy rescue puts("customer right not found.")
    right = Right.find_by_name( "*Access to all shipping actions")
    right.destroy  rescue puts("attachment shipping not found.")
    right = Right.find_by_name( "*Access to all vendor actions")
    right.destroy  rescue puts("vendor right not found.")
    right = Right.find_by_name( "*Access to all product actions")
    right.destroy  rescue puts("products right not found.")
    right = Right.find_by_name( "*Access to all order actions")
    right.destroy  rescue puts("order right not found.")
    right = Right.find_by_name( "*Access to all order item actions")
    right.destroy  rescue puts("order items right not found.")
    right = Right.find_by_name( "*Access to all pricing actions")
    right.destroy  rescue puts("pricing right not found.")
    right = Right.find_by_name( "*Access to all inventory actions")
    right.destroy  rescue puts("inventory right not found.")
    right = Right.find_by_name( "*Access to all menu actions")
    right.destroy  rescue puts("menu right not found.")
    right = Right.find_by_name( "*Access to all attachment actions")
    right.destroy  rescue puts("attachment right not found.")
  end
end

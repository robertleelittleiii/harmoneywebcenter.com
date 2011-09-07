class InventoriesController < ApplicationController
  # GET /inventories
  # GET /inventories.json
  def index
    @inventories = Inventory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json=>@inventories} 
    end
  end

  # GET /inventories/1
  # GET /inventories/1.json
  def show
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=>@inventory }
    end
  end

  # GET /inventories/new
  # GET /inventories/new.json
  def new
    @inventory = Inventory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json=>@inventory}
    end
  end

  # GET /inventories/1/edit
  def edit
    @inventory = Inventory.find(params[:id])
  end

  # POST /inventories
  # POST /inventories.json
  def create
    @inventory = Inventory.new(params[:inventory])

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to @inventory, :notice=>"Inventory was successfully created." }
        format.json { render :json=>@inventory, :status=>:created, :location=>@inventory }
      else
        format.html { render :action=>"new" }
        format.json { render :json=>@inventory.errors, :status=>:unprocessable_entry }
      end
    end
  end

  # PUT /inventories/1
  # PUT /inventories/1.json
  def update
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      if @inventory.update_attributes(params[:inventory])
        format.html { redirect_to @inventory, :notice=>"Inventory was successfully updated."}
        format.json { head :ok }
      else
        format.html { render :action=>"edit" }
        format.json { render :json=>@inventory.errors, :status=>"unprocessable_entry" }
      end
    end
  end

  # DELETE /inventories/1
  # DELETE /inventories/1.json
  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url }
      format.json { head :ok }
    end
  end
  
   # CREATE_EMPTY_RECORD /inventories/1
   # CREATE_EMPTY_RECORD /inventories/1.json

  def create_empty_record
    @inventory = Inventory.new
    @inventory.product_id=params[:product_id]
    
    @inventory.expiration_date = (Time.now + 1).to_date;
    @inventory.lot_no="n/a"
    @inventory.quantity_on_hand="0"
    @inventory.save
    
    redirect_to(:controller=>:inventories, :action=>:edit, :request_type=>params[:request_type], :id=>@inventory)
  end

  
end

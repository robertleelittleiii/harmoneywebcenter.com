class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json=>@products} 
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=>@product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json=>@product}
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @inventory = @product.inventories
    @vendor = Vendor.find(@product.vender_id)rescue {}
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, :notice=>"Product was successfully created." }
        format.json { render :json=>@product, :status=>:created, :location=>@product }
      else
        format.html { render :action=>"new" }
        format.json { render :json=>@product.errors, :status=>:unprocessable_entry }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, :notice=>"Product was successfully updated."}
        format.json { head :ok }
      else
        format.html { render :action=>"edit" }
        format.json { render :json=>@product.errors, :status=>"unprocessable_entry" }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :ok }
    end
  end
  
   # CREATE_EMPTY_RECORD /products/1
   # CREATE_EMPTY_RECORD /products/1.json

  def create_empty_record
    @product = Product.new
    @product.vender_id = "0"
    @product.name="New Product"
    @product.description="New Description"
    @product.ndc_no="0"
    @product.item_no="0"
    @product.save
    
    redirect_to(:controller=>:products, :action=>:edit, :id=>@product)
  end
  
  def show_inventory
    @product = Product.find(params[:id])
    @inventory = @product.inventories
  end

  
end

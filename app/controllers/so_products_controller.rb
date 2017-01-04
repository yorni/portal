class SoProductsController < ApplicationController
  before_action :set_so_product, only: [:show, :edit, :update, :destroy]

  # GET /so_products
  # GET /so_products.json
  def index
    @so_products = SoProduct.all
  end

  # GET /so_products/1
  # GET /so_products/1.json
  def show
  end

  # GET /so_products/new
  def new
    @so_product = SoProduct.new
  end

  # GET /so_products/1/edit
  def edit
  end

  # POST /so_products
  # POST /so_products.json
  def create
    @so_product = SoProduct.new(so_product_params)

    respond_to do |format|
      if @so_product.save
        format.html { redirect_to @so_product, notice: 'So product was successfully created.' }
        format.json { render :show, status: :created, location: @so_product }
      else
        format.html { render :new }
        format.json { render json: @so_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /so_products/1
  # PATCH/PUT /so_products/1.json
  def update
    respond_to do |format|
      if @so_product.update(so_product_params)
        format.html { redirect_to @so_product, notice: 'So product was successfully updated.' }
        format.json { render :show, status: :ok, location: @so_product }
      else
        format.html { render :edit }
        format.json { render json: @so_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /so_products/1
  # DELETE /so_products/1.json
  def destroy
    @so_product.destroy
    respond_to do |format|
      format.html { redirect_to so_products_url, notice: 'So product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_so_product
      @so_product = SoProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def so_product_params
      params.require(:so_product).permit(:institution_id, :product_id, :contract_id, :date, :count)
    end
end

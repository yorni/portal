class SyncProductsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json'}
    
  def create
    product = Product.find_by code: product_params["code"]
      
    if product 
        product.name = product_params["name"]
    else
        product = Product.new(product_params)
    end

    respond_to do |format|
      if product.save
        lcHashOk = { return_status: true}
        format.json { render :json => lcHashOk }
        format.xml { render :xml => lcHashOk }
      else
        lcHashError = { return_status: false, errors: institution.errors }
        format.json { render :json => lcHashError }
        format.xml { render :xml => lcHashError }
      end
    end
  end    
    
private 
def product_params
    params.require(:sync_product).permit(:code, :name)    
end

end

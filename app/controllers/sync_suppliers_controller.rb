class SyncSuppliersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json'}
    
  def create
    supplier = Supplier.find_by code: supplier_params["code"]
      
    if supplier 
        supplier.name = supplier_params["name"]        
    else
        supplier = Supplier.new(supplier_params)
    end
      
    respond_to do |format|
      if supplier.save
        lcHashOk = { return_status: true}
        format.json { render :json => lcHashOk }
        format.xml { render :xml => lcHashOk }
      else
        lcHashError = { return_status: false, errors: supplier.errors }
        format.json { render :json => lcHashError }
        format.xml { render :xml => lcHashError }
      end
    end
  end    
    
private 
def supplier_params
    params.require(:sync_supplier).permit(:code, :name)    
end

end

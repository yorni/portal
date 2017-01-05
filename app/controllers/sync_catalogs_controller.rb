class SyncCatalogsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json'}
      
def branch_update
    Branch.create!(code: params[:code], name: params[:name]) if Branch.where(code: params[:code]).update_all(name: params[:name]).zero?
    render json: { result: true }
end
    
    
 def institution_update
    branch = Branch.find_by code: params[:branch_code]
    Institution.create!(code: params[:code], name: params[:name], branch_id: branch.id) if Institution.where(code: params[:code]).update_all(name: params[:name], branch_id: branch.id).zero?
    render json: { result: true }   
  end       
    
        
def product_update
    Product.create!(code: params[:code], name: params[:name]) if Product.where(code: params[:code]).update_all(name: params[:name]).zero?
    render json: { result: true }
end
       
         
def supplier_update
    Supplier.create!(code: params[:code], name: params[:name]) if Supplier.where(code: params[:code]).update_all(name: params[:name]).zero?
    render json: { result: true }
end
    
end




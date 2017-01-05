class SyncBranchsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json'}
    
  def create
    branch = Branch.find_by code: branch_params["code"]
      
    if branch 
        branch.name = branch_params["name"]
    else
        branch = Branch.new(branch_params)
    end

    respond_to do |format|
      if branch.save
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
def branch_params
    params.require(:sync_branch).permit(:code, :name)    
end

end

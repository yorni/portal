class SyncInstitutionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json'}
    
  def create
    institution = Institution.find_by code: institution_params["code"]
      
    if institution 
        institution.name = institution_params["name"]
    else
        institution = Institution.new
        institution.name = institution_params["name"]
        institution.code = institution_params["code"]
    end
      
    branch = Branch.find_by code: institution_params["branch_code"]
    institution.branch_id = branch.id
      
    respond_to do |format|
      if institution.save
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
def institution_params
    params.require(:sync_institution).permit(:code, :name, :branch_code)    
end

end

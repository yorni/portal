class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
     def index
        @users = User.all
    end
    
    def create
        @user = User.new(user_params)
        if @user.save 
            redirect_to users_path
        else
            render :new
        end
        
        
    end  

    private
    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :is_admin, :is_supplier, :institution_id, :supplier_id)
    end
    
end

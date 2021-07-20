class UsersController < ApplicationController
    def new        
        @user = User.new
    end
    def create        
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome to my Blog app #{user.username}"    
            redirect_to articles_path
        else
            render 'new'
        end 
    end
    private 
        def user_params
            params.require(:user).permit(:email, :username, :password)
        end
    
end
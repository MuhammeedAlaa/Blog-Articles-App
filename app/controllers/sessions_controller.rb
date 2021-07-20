class SessionsController < ApplicationController
    def new
    end

    def create
        @session = session_params
        @user = User.find_by(email: @session[:email].downcase)
        if @user && @user.authenticate(@session[:password])
            flash[:success] = "You are loged in succesfully"
            session[:user_id] = @user.id    
            redirect_to user_path(@user)
        else
            flash[:danger] = "Invalid email or password"    
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "You are loged out succesfully"
        redirect_to root_path
    end    
    private 
        def session_params
            params.require(:session).permit(:email, :password)
        end
end
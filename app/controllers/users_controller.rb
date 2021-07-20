class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update]
    before_action :require_admin, only: [:destroy]
    def new        
        @user = User.new
    end
    def create        
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome to my Blog app #{@user.username}"   
            session[:user_id] = @user.id  
            redirect_to user_path(@user)
        else
            render 'new'
        end 
    end
    def edit 
    end
    def show 
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 2)
    end
    def index 
        @users = User.paginate(page: params[:page], per_page: 2)
    end
    def update
        if @user.update(user_params)
            flash[:success] = "Your info was succesfully updated"    
            redirect_to root_path
        else
            render 'edit'
        end
    end
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = "#{@user.username} is succesfully deleted"
        redirect_to users_path
    end
    
    private 
        def user_params
            params.require(:user).permit(:email, :username, :password)
        end
        def set_user
            @user = User.find(params[:id])
        end
        def require_same_user
            if current_user != @user
                flash[:danger] = "You can edit your account"
                redirect_to root_path
            end
        end
        def require_admin
            if logged_in?  && !current_user.admin?
                flash[:danger] = "Admin only action"
                redirect_to root_path
            end
        end
end
class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
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

    private 
        def user_params
            params.require(:user).permit(:email, :username, :password)
        end
        def set_user
            @user = User.find(params[:id])
        end
end
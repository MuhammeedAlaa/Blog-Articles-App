class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :show, :update, :destroy]
    def index
        @articles = Article.all
    end
    def new
        @article = Article.new
    end
    def destroy
        @article.destroy
        flash[:danger] = "The article was succesfully deleted"
        redirect_to articles_path
    end
    def create
        # render plain: params[:article].inspect
        @article = Article.new(article_params)
        if @article.save
            flash[:success] = "Article was succesfully created"    
            redirect_to article_path(@article)
        else
            render 'new'
        end 
    end

    def show 
    end

    def edit 
    end
    
    def update
        if @article.update(article_params)
            flash[:success] = "Article was succesfully updated"    
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    private 
    def set_article
        @article = Article.find(params[:id])
    end
    def article_params
        params.require(:article).permit(:title, :description)
    end
end
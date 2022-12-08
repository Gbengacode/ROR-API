module Api 
    module V1
        class ArticlesController < ApplicationController
            skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
            def index
                article = Article.all
              render json: article, status: 200
            end
        
            def show
                article = Article.find_by(id: params[:id])
                if article
                    render json: article, status: 200
                else 
                    render json: {
                        error: "error finding",
                    }, status: 400
                end
            end
            
            def create
                article = Article.new(article_params)
                if article.save
                    render json: article, status: 201
                else 
                    render json: {
                        error: article.errors,
                    }, status: 422
                end
            end
            def update
                article = Article.find_by(id: params[:id])
                if article
                    article.update(article_params)
                    render json: {
                      article: article,
                      success: true,
                      msg: "updated"
                    },
                    status: 200
                          
                else 
                    render json: {
                        error: "article not found"
                    }, 
                    status: 404
                end
            end
            
            def destroy
                article = Article.find_by(id: params[:id])
                if article
                    article.destroy
                    render json: {
                        success: true,
                        msg: "article deleted"
                    },
                    status: 200
                else 
                    render json: {
                        success: false,
                        error: "Did not find article"
                    },
                    status: 404
                end
            end
        
            private
            def article_params
                 params.require(:article).permit(:title, :body, :author)
               
              end
        end
    end
end

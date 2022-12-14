module Api 
    module V1
        class ArticlesController < ApplicationController
            skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
            def index
                article = Article.limit(limit).offset(params[:offset])
              render json: ArticlesRepresenter.new(article).as_json, status: 200
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
                author = Author.create(author_params)
                article = Article.new(article_params.merge(author_id: author.id))
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
            def limit
                max_limit = 100
              [params.fetch(:limit, max_limit).to_i, max_limit].min
            end
            def article_params
                 params.require(:article).permit(:title, :body)
               
              end
            def author_params
                params.require(:author).permit(:firstmame, :lastname, :age)
            end
        end
    end
end

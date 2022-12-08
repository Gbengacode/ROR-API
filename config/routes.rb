Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
        # resources :articles, only: [:index, :show, :create, :update, :destroy]
      get "articles" => "articles#index"
      get "articles/:id" => "articles#show"
      post "articles" => "articles#create"
      delete "articles/:id" => "articles#destroy"
      put "articles/:id" => "articles#update"
    end
  end
end

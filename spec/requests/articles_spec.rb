require 'rails_helper'

describe 'article api', type: :request do
    it 'return alll the articles' do#         # FactoryBot.create(:article, title: 'first title', body: 'first body', author: 'author man')
        get '/api/v1/articles'
        puts JSON.parse(response.body).size
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(12)
    end
end


describe 'article api', type: :request do
    it 'create a new book ' do
         expect{
             post '/api/v1/articles', params:  { article: { title: 'hello', body: 'it is the body', author: 'author body'}}
         }.to change { Article.count}. from(4).to(5)
         expect(response).to have_http_status(201)
    end
end

describe 'article api', type: :request do
    article = FactoryBot.create(:article, title: 'hello', body: 'hello', author: 'hello')
    puts article.id
    it 'delete a book' do
           delete "/api/v1/articles/#{article.id}"
           expect(response).to have_http_status(200)
     end
end
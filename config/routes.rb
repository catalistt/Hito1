Rails.application.routes.draw do
  get 'api/news'
  get 'api/dates'
  post 'api/tweets', to: "tweets#create"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :tweets
  resources :likes
  resources :retweets
  get '/api/:news', to: 'api#news' 
  get '/api/:from/:to', to: 'api#dates'
  get 'tweets/show'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do 
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
      end
    end
  end

  root "tweets#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

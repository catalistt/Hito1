Rails.application.routes.draw do
  get 'api/news'
  get 'api/dates'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :tweets
  resources :likes
  resources :retweets
  get '/api/:news', to: 'api#news' 
  get '/api/:from/:to', to: 'api#dates'
  get 'tweets/show'
  root "tweets#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

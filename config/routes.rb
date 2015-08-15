Rails.application.routes.draw do
  resources :documents
  resources :news_feeds
  resources :dashboards
  devise_for :users
  resource :users
  root 'user#home'

  get "/wyncode" => redirect("https://wyncode.co/")
  get "/about" => 'user#about'


end

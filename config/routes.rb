Rails.application.routes.draw do
  get 'uploads/new'

  get 'uploads/create'

  get 'uploads/index'

  resources :documents
  resources :uploads
  resources :news_feeds
  resources :dashboards
  devise_for :users
  resource :users
  root 'user#home'

  get "/wyncode" => redirect("http://wyncode.co/")
  get "/about" => 'user#about'


end

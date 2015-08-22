Rails.application.routes.draw do
  get 'calendar/show'

  get 'uploads/new'
  get 'uploads/create'
  get 'uploads/index'
  get 'dashboards/join'
  put 'dashboards/join'
  post 'dashboards/search'

  resources :uploads
  resources :news_feeds
  resources :events

  resources :dashboards, shallow: true do
    resources :uploads
    resources :news_feeds
    resources :events
  end

  devise_for :users
  resource :users
  resource :calendar, only: [:show], controller: :calendar
  root 'user#home'

  get "/wyncode" => redirect("http://wyncode.co/")
  get "/about" => 'user#about'


end

Rails.application.routes.draw do
  resources :documents
  resources :news_feeds
  resources :dashboards
  devise_for :users
  resource :users
  root 'user#home'

  get "/wyncode" => redirect("http://wyncode.co/")

  # devise_scope :user do get "/sign_out" => "devise/sessions#destroy"
  # end
end

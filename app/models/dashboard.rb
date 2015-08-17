class Dashboard < ActiveRecord::Base
  has_many :user_dashboards
  has_many :users, through: :user_dashboards 
  has_many :uploads
  has_many :news_feeds
end

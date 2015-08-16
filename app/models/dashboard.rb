class Dashboard < ActiveRecord::Base
  belongs_to :user
  has_many :documents
  has_many :news_feeds
end

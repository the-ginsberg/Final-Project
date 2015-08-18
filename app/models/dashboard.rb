class Dashboard < ActiveRecord::Base
  belongs_to :user
  has_many :uploads
  has_many :news_feeds, dependent: :destroy
end

class Dashboard < ActiveRecord::Base
  has_many :user_dashboards
  has_many :users, through: :user_dashboards
  has_many :uploads
  has_many :news_feeds

  validates :user_id, presence: true


  def set_user(user)
    self.user_id = user.id
  end

end

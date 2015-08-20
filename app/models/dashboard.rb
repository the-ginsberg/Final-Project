class Dashboard < ActiveRecord::Base
  has_many :users
  has_many :uploads, dependent: :destroy
  has_many :news_feeds, dependent: :destroy

  validates :user_id, presence: true
  validates :title, uniqueness: true


  def set_user(user)
    self.user_id = user.id
  end

end

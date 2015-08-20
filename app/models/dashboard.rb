class Dashboard < ActiveRecord::Base
  has_many :invites
  has_many :users, through: :invites
  has_many :uploads, dependent: :destroy
  has_many :news_feeds, dependent: :destroy

  validates :user_id, presence: true
  validates :token, uniqueness: true


  def self.search(search)
    where("token LIKE ?", "%#{search}%")
  end

  def set_user(user)
    self.user_id = user.id
  end

end

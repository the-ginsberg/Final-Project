class Dashboard < ActiveRecord::Base
  belongs_to :user
  has_many :dashboard_memberships
  has_many :members, through: :dashboard_memberships
  has_many :uploads, dependent: :destroy
  has_many :news_feeds, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :user, presence: true
  validates :token, uniqueness: true

  def find_or_create_member(user)
    if !members.include?(user)
      members << user
    end
  end

  def self.search(search)
    where("token LIKE ?", "%#{search}%")
  end

  # this is bad
  def set_user(user)
    self.user_id = user.id
  end

  def events_by_date
    events.group_by(&:date)
    # events.group_by{ |event| event.date }
  end

end

class NewsFeed < ActiveRecord::Base
  belongs_to :dashboard
  validates :dashboard_id, presence: true

  def self.items_for_dashboard(dashboard)
    order("created_at DESC").limit(3).where(dashboard_id: dashboard.id)
  end

end

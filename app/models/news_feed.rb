class NewsFeed < ActiveRecord::Base
  belongs_to :dashboard
  validates :dashboard_id, presence: true

  def set_dashboard(dashboard)
    self.dashboard_id = dashboard.id
  end
end

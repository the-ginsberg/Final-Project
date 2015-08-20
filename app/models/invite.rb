class Invite < ActiveRecord::Base
belongs_to :user
belongs_to :dashboards

validates :user_id, presence: true
validates :dashboard_id, presence: true


end

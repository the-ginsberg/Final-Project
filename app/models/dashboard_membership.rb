class DashboardMembership < ActiveRecord::Base
  belongs_to :dashboard
  belongs_to :member, class_name: 'User'
end

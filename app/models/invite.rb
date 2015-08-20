class Invite < ActiveRecord::Base
belongs_to :user
belongs_to :dashboards

end

class Upload < ActiveRecord::Base
  belongs_to :dashboard
  validates :dashboard_id, presence: true
end

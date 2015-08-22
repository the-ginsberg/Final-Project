class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :dashboards
  has_many :dashboard_memberships, foreign_key: :member_id
  has_many :memberships, through: :dashboard_memberships, source: :dashboard

  # custom validation
  # not valid if dashboard_memberships has two of the same dashboard

end

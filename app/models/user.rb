class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :dashboards
  has_many :dashboard_memberships
  has_many :memberships, through: :dashboard_memberships, source: :member

end

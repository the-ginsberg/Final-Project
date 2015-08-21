class AddMembersToDashboards < ActiveRecord::Migration
  def change
    add_column :dashboards, :member_id, :integer
  end
end

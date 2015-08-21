class CreateDashboardMemberships < ActiveRecord::Migration
  def change
    create_table :dashboard_memberships do |t|
      t.integer :member_id
      t.integer :dashboard_id

      t.timestamps null: false
    end
  end
end

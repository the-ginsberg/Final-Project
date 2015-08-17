class AddColumnDamnDashboardIdToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :dashboard_id, :integer
  end
end

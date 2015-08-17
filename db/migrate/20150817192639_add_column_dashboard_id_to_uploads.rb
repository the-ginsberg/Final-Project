class AddColumnDashboardIdToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :dashboard_id, :string
  end
end

class RemoveColumnnDashboardIdFromUploads < ActiveRecord::Migration
  def change
    remove_column :uploads, :dashboard_id, :string
  end
end

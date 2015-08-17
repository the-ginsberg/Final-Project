class RemoveColumnCalendarFromDashboards < ActiveRecord::Migration
  def change
    remove_column :dashboards, :calendar, :string
  end
end

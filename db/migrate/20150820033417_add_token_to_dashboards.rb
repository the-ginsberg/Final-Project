class AddTokenToDashboards < ActiveRecord::Migration
  def change
    add_column :dashboards, :token, :string
  end
end

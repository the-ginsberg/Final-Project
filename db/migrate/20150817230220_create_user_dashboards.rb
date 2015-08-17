class CreateUserDashboards < ActiveRecord::Migration
  def change
    create_table :user_dashboards do |t|
      t.boolean :role
      t.references :user, index: true, foreign_key: true
      t.references :dashboard, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

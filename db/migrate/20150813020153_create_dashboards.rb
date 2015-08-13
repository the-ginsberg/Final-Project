class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.string :title
      t.string :calendar
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

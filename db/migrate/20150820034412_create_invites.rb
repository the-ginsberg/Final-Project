class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.integer :dashboard_id

      t.timestamps null: false
    end
  end
end

class AddFourFuckingColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :moderator, :boolean
    add_column :users, :phone_number, :string
  end
end

class AddColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :time, :time
  end
end

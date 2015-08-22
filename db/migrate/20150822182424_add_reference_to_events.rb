class AddReferenceToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :dashboard, index: true, foreign_key: true
  end
end

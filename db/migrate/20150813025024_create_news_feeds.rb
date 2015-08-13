class CreateNewsFeeds < ActiveRecord::Migration
  def change
    create_table :news_feeds do |t|
      t.string :title
      t.text :body
      t.integer :dashboard_id
      t.references :dashboard, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

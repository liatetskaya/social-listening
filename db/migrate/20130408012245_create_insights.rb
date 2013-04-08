class CreateInsights < ActiveRecord::Migration
  def change
    create_table :insights do |t|
      t.string :Page
      t.integer :page_fan_adds
      t.integer :page_views
      t.integer :page_engaged_users
      t.integer :page_places_checkins
      t.integer :page_posts_impressions

      t.timestamps
    end
  end
end

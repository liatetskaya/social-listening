class Insight < ActiveRecord::Base
  attr_accessible :Page, :page_engaged_users, :page_fan_adds, :page_places_checkins, :page_posts_impressions, :page_views
end

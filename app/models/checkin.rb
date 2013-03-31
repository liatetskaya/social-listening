class Checkin < ActiveRecord::Base
  attr_accessible :created_at, :message, :notes, :push_id, :stat_checkins_count, :stat_users_count, :user_first_name, :user_gender, :user_id, :user_last_name, :user_photo, :user_profile, :venue_id
end

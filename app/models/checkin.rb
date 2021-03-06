class Checkin < ActiveRecord::Base
  attr_accessible :created_at, :rm_service_id, :rm_merchant_id, 
    :rm_user_id, 
    :rm_created_at, 
    :rm_message_id,
    :rm_message_url,
    :user_first_name,
    :user_last_name,
    :user_screen_name,
    :user_photo_url,
    :user_info, 
    :post_text, 
    :post_url, 
    :picture, 
    :location, 
    :place_id, 
    :notes, 
    :message, 
    :client_id 

    belongs_to :profile

end

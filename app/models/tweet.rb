class Tweet
  class << self
    def search
      tw_profiles = Profile.find(:all, :conditions => ["service = ? ", "TWITTER"])
      tw_profiles.each do |profile|
        tw_access_token = JSON.parse(profile.token)
        tw_client = TwitterOAuth::Client.new(
          :consumer_key => ENV['tw_client_id'],
          :consumer_secret => ENV['tw_client_secret'],
          :token => tw_access_token['token'],
          :secret => tw_access_token['secret']
        )

        if tw_client.authorized?
          resp = tw_client.search('#', {:geocode => '42.353121,-71.052882,0.1km'})

          # TODO: verify push secret

          @checkin = Checkin.new

          @checkin.rm_service_id = "Twitter"
          @checkin.rm_message_id = resp['id_str']
          @checkin.rm_user_id = resp['user']['id_str']
 #         @checkin.rm_merchant_id = resp['user']['']
          @checkin.user_first_name = resp['user']['name']
          @checkin.user_last_name = resp['user']['lastName']
          @checkin.user_photo = resp['user']['profile_img_url']
          @checkin.user_screen_name = resp['user']['screen_name']
 #         @checkin.user_info= resp['user']['name']
          @checkin.post_text= resp['user']['text']
 #         @checkin.post_url= resp['user']['name']
 #         @checkin.picture= resp['user']['']
          @checkin.coordinates= resp['user']['coordinates']
  #        @checkin.place_id= resp['user']['name']
          @checkin.message= resp
          @checkin.save

          #Rails.logger.info search['results'].inspect
        end
      end
    end
  end
end

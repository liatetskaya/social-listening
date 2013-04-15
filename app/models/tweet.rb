class Tweet
  class << self
    def search
      tw_profiles = Profile.find(:all, :conditions => ["service = ? ", "TWITTER"])
      Rails.logger.info tw_profiles.inspect
      if tw_profiles.count > 0
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
            Rails.logger.info resp.inspect
            if resp['results'].count > 0
              Rails.logger.info search['results'].count.inspect
              resp['results'].each do |res|
                @checkin = Checkin.new

                @checkin.rm_service_id = "Twitter"
                @checkin.rm_message_id = res['id_str']
                @checkin.rm_user_id = res['from_user_id_str']
                @checkin.user_first_name = res['from_user_name']
                @checkin.user_last_name = res['user_lastName']
                @checkin.user_photo = res['profile_imgage_url_https']
                @checkin.user_screen_name = res['user']['screen_name']
                @checkin.post_text = res['text']
                @checkin.coordinates = res['geo']['coordinates']
                @checkin.message = res
                @checkin.save
              end
            end
            #Rails.logger.info search['results'].inspect
          end
        end
      end
    end
  end
end

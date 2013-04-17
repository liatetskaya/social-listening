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
          results = tw_client.search('#', {:geocode => '42.353121,-71.052882,1km'})['results']
          
          if results != nil && results.count > 0
            results.each do |res|
              @checkin = Checkin.new

              @checkin.rm_service_id = "Twitter"
              @checkin.rm_message_id = res['id_str']
              @checkin.rm_user_id = res['from_user_id_str']
              @checkin.user_first_name = res['from_user_name']
              #@checkin.user_last_name = res['user_lastName']
              @checkin.user_photo = res['profile_imgage_url_https']
              @checkin.user_screen_name = res['from_user']
              @checkin.post_text = res['text']
              if res['geo'] != nil
                @checkin.location = res['geo']['coordinates']
              else
                @checkin.location = res['location']
              end
              #@checkin.coordinates = res['geo']['coordinates']
              @checkin.message = res
              @checkin.save
            end
          end
        else
          Rails.logger.info "not authorized"
        end
      end
    end
  end
end

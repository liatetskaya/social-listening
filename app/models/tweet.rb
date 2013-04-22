class Tweet
  class << self
    def search
      tw_profiles = Profile.find(:all, :conditions => ["service = ? ", "TWITTER"])
      tw_profiles.each do |profile|
        next if profile.location.blank? && profile.keywords.blank?
        token = ENV['tw_access_token']
        secret = ENV['tw_access_secret']
        if profile.token.present?
          tw_access_token = JSON.parse(profile.token)
          token = tw_access_token['token']
          secret = tw_access_token['secret']
        end
        next if token.blank?
        tw_client = Twitter::Client.new(
          :consumer_key => ENV['tw_client_id'],
          :consumer_secret => ENV['tw_client_secret'],
          :oauth_token => token,
          :oauth_token_secret => secret
        )

        begin
          query = if profile.keywords.present?
                    profile.keywords
                  else
                    '#'
                  end
          
          options = {:count => 10, :result_type => 'recent', :since_id => profile.last_message_id}
          if profile.location.present?
            options[:geocode] = profile.location
          end
          results = tw_client.search("#{query} -rt", options)[:results]
          if results.present?
            results.each do |res|
              @checkin = Checkin.new
              
              @checkin.rm_service_id = 'TWITTER'
              @checkin.rm_message_id = res[:id]
              if res[:user] != nil
                user = res[:user]
                @checkin.rm_user_id = user[:id]
                @checkin.user_first_name = user[:name]
                @checkin.user_screen_name = user[:screen_name]
                @checkin.profile_id = profile.id
                @checkin.user_photo = user[:profile_image_url]
                @checkin.rm_message_url = "https://twitter.com/"+ user[:screen_name]+"/status/"+ res[:id]
              end
              @checkin.post_text = res[:text]
              @checkin.message = res.to_json
              
              # That section should be last, saves the recored only if there's a location
              if res[:geo] != nil && res[:geo][:coordinates] != nil
                @checkin.location = res[:geo][:coordinates].to_json
                @checkin.save
              end
            end
          end
          profile.last_message_id = @checkin.rm_message_id
          profile.save
        rescue
          Rails.logger.error "Error: #{$!}"
        end
      end
    end
  end
end

class Instagram
  class << self
    def search
      ins_profiles = Profile.find(:all, :conditions => ["service = ? ", "INSTAGRAM"])
      ins_profiles.each do |profile|
	    next if profile.location.blank? && profile.keywords.blank?
        token = ENV['ins_access_token']
        secret = ENV['ins_access_secret']
        if profile.token.present?
          ins_access_token = JSON.parse(profile.token)
          token = ins_access_token['token']
          secret = ins_access_token['secret']
        end
        next if token.blank?
        tw_client = Instagram::Client.new(
          :consumer_key => ENV['ins_client_id'],
          :consumer_secret => ENV['ins_client_secret'],
          :oauth_token => token,
          :oauth_token_secret => secret
        )

        begin
          query = if profile.keywords.present?
                    profile.keywords
                  else
                    '#'
                  end
          
          options = {:count => 10, :result_type => 'recent'}
          if profile.location.present?
            options[:geocode] = profile.location
          end
          results = Instagram.media_search("37.7808851","-122.3948632")
          
          if results.present?
            results.each do |res|
	      #Rails.logger.info res[:id].inspect
              #Rails.logger.info res[:user][:id].inspect
              #Rails.logger.info res[:user][:name].inspect
              #Rails.logger.info res[:user][:screen_name].inspect
              #Rails.logger.info res[:geo].inspect
              #Rails.logger.info res[:profile_image_url].inspect
              #Rails.logger.info res[:location].inspect
              #Rails.logger.info res[:text].inspect

              @checkin = Checkin.new

              @checkin.rm_service_id = 'INSTAGRAM'
              @checkin.rm_message_id = res[:id]
              if res[:user] != nil
                user = res[:user]
                @checkin.rm_user_id = user[:id]
                @checkin.user_first_name = user[:name]
                @checkin.user_screen_name = user[:screen_name]
                #@checkin.user_last_name = user[:lastName]
                @checkin.user_photo = user[:profile_image_url]
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
        rescue
          Rails.logger.error "Error #{$!}"
        end
      end
    end
    def update
      # long lat radius
      
    end
  end
end

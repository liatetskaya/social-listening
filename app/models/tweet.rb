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
          search = tw_client.search('#', {:geocode => '42.353121,-71.052882,0.1km'})
          Rails.logger.info search['results'].inspect
        end
      end
    end
  end
end

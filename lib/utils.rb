require 'tweetstream'

module Utils
  class TwitterReader
    def initialize
      ### TODO: initialize either with parameters or from the database
      TweetStream.configure do |config|
        config.username     = ''
        config.password     = ''
        config.auth_method  = :basic
      end
    end   

    def stream
      # Rails.logger.info "#{Time.now}.\n"
      # SocialRecord.all

      @client = TweetStream::Client.new

      @client.on_delete do |status_id, user_id|
        # Tweet.delete(status_id)
      end

      @client.on_limit do |skip_count|
        # do something
      end

      @client.on_enhance_your_calm do
        # do something
      end

      @client.on_reconnect do |timeout, retries|
        # Do something with the reconnect
      end

      @client.on_error do |message|
        # puts "ERROR: #{message}"
        Rails.logger.error "#{message}"
      end

      @client.track('StartupInst', '@StartupInst', '#StartupInst', 'bieber') do |status|
        # puts "#{status.text}"
        # puts status.inspect
        Rails.logger.info "#{status.text}"
        result = JSON.parse(status.text)
        # tweet_id
        # place
        # coordinates
        # user
        # screen_name
        # geo_enabled
        # profile_image_url
        #

#        SocialRecord.all
      end
    end
  end
end

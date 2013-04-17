require 'tweetstream'

module Utils
  class TwitterReader
    def initialize
      ### TODO: initialize either with parameters or from the database
      TweetStream.configure do |config|
        config.username     = 'change_it_not'
        config.password     = 'bcd9D=ec$'
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

      @client.track('StartupInst', '@StartupInst', '#StartupInst', '') do |status|
        # puts "#{status.text}"
        # puts status.inspect
        # Rails.logger.info "#{status.text}"
        SocialRecord.all
      end
    end
  end
  class FacebookInsights
    def getInsights
      fb_auth = FbGraph::Auth.new('645691315457792', '9644df098a064f82f9ea547ec0d63744')
    end
  end
end

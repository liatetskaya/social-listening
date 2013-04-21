class Post
  class << self
    def search
      fb_profiles = Profile.find(:all, :conditions => ["service = ? ", "FACEBOOK"])
      fb_profiles.each do |profile|
        begin
          results = FbGraph::Searchable.search('', :access_token => profile.token.to_s, :type => 'location', :place => profile.service_id)
          Rails.logger.info results.inspect
        rescue
          Rails.logger.error "Error #{$!}"
        end
      end
    end
  end
end

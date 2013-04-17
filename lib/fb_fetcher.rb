#!/usr/bin/env ruby

# You might want to change this
#ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")

@fb_profiles = Profile.find(:all, :conditions => ["service = ? ", "FACEBOOK"])
if @fb_profiles.count > 0
	@fb_profiles.each do |fb_profile|
	    # call Graph API for each Page
	     @insights = FbGraph::Page.new('QuincyBuiltSoftware').insights(
          :access_token => @profile.token
        )

	end
end
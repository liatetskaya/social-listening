require 'fb_graph'
class StatController < ApplicationController
 
  def index
  	app = FbGraph::Application.new('645691315457792', :secret => '9644df098a064f82f9ea547ec0d63744')
	access_token = app.get_access_token
#    auth = FbGraph::Auth.new('645691315457792', '9644df098a064f82f9ea547ec0d63744')
#    auth.exchange_token! access_token
#    token = auth.acess_token

    page = FbGraph::Page.new('TeamSwipely') #FbGraph')
    @insights = page.insights(:access_token => access_token)
    @likes = page.insights(:access_token => access_token, :metrics => 'page_like_adds')
   
   # @likes = @insights[0].Page_fan_adds
    tw_profiles = Profile.find(:all, :conditions => ["service = ? ", "TWITTER"])
    tw_access_token = JSON.parse(tw_profiles[0].token)
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

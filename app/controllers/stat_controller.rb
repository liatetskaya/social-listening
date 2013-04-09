require 'fb_graph'
class StatController < ApplicationController
 
  def index
  	app = FbGraph::Application.new('645691315457792', :secret => '9644df098a064f82f9ea547ec0d63744')
	access_token = app.get_access_token
#    auth = FbGraph::Auth.new('645691315457792', '9644df098a064f82f9ea547ec0d63744')
#    auth.exchange_token! access_token
#    token = auth.acess_token

    page = FbGraph::Page.new('TeamSwipely') #FbGraph')
   # @insights = page.insights(:access_token => access_token)
   # @likes = @insights[0].Page_fan_adds

  end
end
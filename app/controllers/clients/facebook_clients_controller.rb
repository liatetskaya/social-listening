class Clients::FacebookClientsController < ApplicationController
	before_filter :authenticate_user!

	def new
		@fb_auth = fb_auth

		# redirect user to facebook
		redirect_to @fb_auth.client.authorization_uri(
		  :scope => [:read_insights, :offline_access]
		)
	end

	def callback
		@fb_auth = fb_auth
		@fb_auth.client.authorization_code = params[:code]
		access_token = @fb_auth.client.access_token! :client_auth_body
		@fb_auth.exchange_token! access_token

		#TODO: store the @fb_auth.access_token in the model
		Rails.logger.info @fb_auth.access_token.inspect

		#TODO: move that to another controller
		#page = FbGraph::Page.new('QuincybuiltSoftwareHq').insights(
		#	:access_token => @fb_auth.access_token
		#)
		#Rails.logger.info page.inspect

		redirect_to root_path
	end

	def fb_auth
		fb_auth = FbGraph::Auth.new(ENV['fb_client_id'], ENV['fb_client_secret'])
		fb_auth.client.redirect_uri = callback_facebook_clients_url
		fb_auth
	end
end

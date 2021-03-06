class Clients::FoursquareClientsController < ApplicationController
	before_filter :authenticate_user!

	def new
		# https://developer.foursquare.com/overview/auth
		#Rails.logger.info current_user.inspect
		options = {
		  redirect_uri: callback_foursquare_clients_url,
		}
		redirect_to client.auth_code.authorize_url options
	end

	def callback
		if params[:error]
			# TODO: manage error
		end
		token = client.auth_code.get_token params[:code], redirect_uri: callback_foursquare_clients_url

		# to get the user venues
		# FoursquareClient.new(token).user_venues

		#uri = URI('https://api.foursquare.com/v2/venues/managed?oauth_token=' + ACCESS_TOKEN)
        #@res = Net::HTTPS.get_response(uri).body
	    #@res.each do |result|

			profile = Profile.new
	        	profile.user = current_user
	        	profile.service = "FOURSQUARE"
	        	profile.token = token.token
	        	profile.save
	    end
		
		session[:fs_auth] = nil
		redirect_to profiles_path
	end

	private
	def client
		if session[:fs_auth] == nil
			session[:fs_auth]= FoursquareClient.oauth2_client
		end
		session[:fs_auth]
	end
end

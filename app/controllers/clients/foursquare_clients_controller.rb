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
		Profile.new
        Profile.user_id = current_user.user_id
        Profile.service = "FOURSQUARE"
        Profile.token = token.token
        Profile.save
		#current_user.foursquare_user = FoursquareUser.find_or_create_by_access_token(token.token)
		      #session[:user_id] = fsuser.id
		#current_user.save
		#redirect_to profile_path
	end

	private
	def client
	  FoursquareClient.oauth2_client
	end
end

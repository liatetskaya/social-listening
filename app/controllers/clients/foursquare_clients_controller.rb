class Clients::FoursquareClientsController < ApplicationController
	def new
		# https://developer.foursquare.com/overview/auth
		#Rails.logger.info current_user.inspect
		if user_signed_in?
			options = {
			  redirect_uri: callback_foursquare_clients_url + "?local_token=#{current_user.id}",
			}
			redirect_to client.auth_code.authorize_url options
		else
			redirect_to :root
		end
	end

	def callback
		if params[:error]
			# TODO: manage error
		end
		token = client.auth_code.get_token params[:code], redirect_uri: callback_foursquare_clients_url
		fsuser = FoursquareUser.find_or_create_by_access_token(token.token)
		session[:user_id] = fsuser.id
		redirect_to fsuser_path
	end

	private
	def client
	  FoursquareClient.oauth2_client
	end
end
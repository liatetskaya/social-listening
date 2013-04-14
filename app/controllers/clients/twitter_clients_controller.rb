class Clients::TwitterClientsController < ApplicationController
	before_filter :authenticate_user!
	
	def new
		session[:tw_request_token] = tw_auth.request_token(:oauth_callback => callback_twitter_clients_url)
		redirect_to session[:tw_request_token].authorize_url
	end
	
	def callback
		request_token = session[:tw_request_token]
		access_token = tw_auth.authorize(
 			request_token.token,
 			request_token.secret,
 			:oauth_verifier => params[:oauth_verifier]
		)
		
		if tw_auth.authorized?
			# TODO: Save it in the database
			profile = Profile.new
			profile.user = current_user
			profile.service = "TWITTER"
			profile.token = access_token.to_s
			profile.save
		end
		
		# Clear the session attributes
		session[:tw_auth] = nil
		session[:tw_request_token] = nil
		
		redirect_to profiles_path
	end
	
	def tw_auth
		if session[:tw_auth] == nil
			session[:tw_auth] = TwitterOAuth::Client.new(
				:consumer_key => ENV['tw_client_id'],
				:consumer_secret => ENV['tw_client_secret']
			)
		end
		session[:tw_auth]
	end
end

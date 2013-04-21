class Clients::InstagramClientsController < ApplicationController
	before_filter :authenticate_user!

	def new
        redirect_to client.authorize_url(:redirect_uri => callback_instagram_clients_url)
	end

	def callback
		if params[:error]
			# TODO: manage error
		end

        response = client.get_access_token(params[:code], :redirect_uri => callback_instagram_clients_url)
        token = response.access_token
        
        verifyToken = 'some_random_string_should_be_here'
        session[:ins_verify] = verifyToken
        
        client.create_subscription(
            :access_token => token,
            :object => 'geography',
            :aspect => 'media',
            :lat => 42.353121,
            :lng => -71.052882,
            :radius => 1000,
            :callback_url => realtime_instagram_url,
            :verifyToken => verifyToken)

		profile = Profile.new
        profile.user = current_user
        profile.service = "INSTAGRAM"
        profile.token = token
        
        profile.save
        session[:ins_auth] = nil
		redirect_to edit_profile_path(profile)
    end
    

	private
	def client
		if session[:ins_auth] == nil
			session[:ins_auth]= Instagram.client(
                :client_id => ENV['ins_client_id'],
                :client_secret => ENV['ins_client_secret']
            )
		end
		session[:ins_auth]
	end
end

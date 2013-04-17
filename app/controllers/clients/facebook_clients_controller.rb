class Clients::FacebookClientsController < ApplicationController
	before_filter :authenticate_user!

	def new
<<<<<<< HEAD
		@fb_auth = fb_auth

		# redirect user to facebook
		redirect_to @fb_auth.client.authorization_uri(
		  :scope => [:read_insights, :offline_access]
=======
		# redirect user to facebook
		redirect_to fb_auth.client.authorization_uri(
		  :scope => [:read_insights, :offline_access, :manage_pages]
>>>>>>> YL1
		)
	end

	def callback
<<<<<<< HEAD
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
=======
		fb_auth.client.authorization_code = params[:code]
		access_token = fb_auth.client.access_token! :client_auth_body
		fb_auth.exchange_token! access_token
		
		Rails.logger.info fb_auth.access_token.inspect
		
 		me = FbGraph::User.me(fb_auth.access_token.to_s)
        	accounts = me.accounts

 		if accounts.count > 0
            		accounts.each do |acc|
                                # TODO: verify that the user has admin right for the page
                                page = FbGraph::Page.new(acc.identifier).fetch(
                                  :access_token => acc.access_token.to_s,
                                  :fields => :access_token
                                )
                                page.tab!(:app_id => '134358360084677') # TODO: un-hardcode the app id

            			profile = Profile.new
            			profile.user = current_user
            			profile.service = "FACEBOOK"
            			profile.token = acc.access_token
                		profile.status = acc.name
                		profile.user_id = acc.identifier # THIS IS WRONG!!! That is page's id
                		profile.save
            		end
        	end
		
		session[:fb_auth] = nil
		redirect_to profiles_path
	end

	def fb_auth
		if session[:fb_auth] == nil
			session[:fb_auth] = FbGraph::Auth.new(ENV['fb_client_id'], ENV['fb_client_secret'])
			session[:fb_auth].client.redirect_uri = callback_facebook_clients_url
		end
		session[:fb_auth]
>>>>>>> YL1
	end
end

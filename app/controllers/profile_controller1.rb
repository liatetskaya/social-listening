class ProfileController < ApplicationController
  before_filter :authenticate_user!
 
  def index
    @fs_user = current_user.foursquare_user
    if !@fs_user.nil?
      @fs_user_info = @fs_user.user_info
      @fs_venues = @fs_user.client.user_venues
      # TODO: update the venues in the database?
    end
  end
end
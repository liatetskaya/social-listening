class CheckinsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    resp = JSON.parse(params['checkin'])
    # TODO: verify push secret
    
    @checkin = Checkin.new
    
    @checkin.push_id = resp['id']
    @checkin.created_at = resp['created_at']
    @checkin.user_id = resp['user']['id']
    @checkin.user_gender = resp['user']['gender']
    @checkin.user_first_name = resp['user']['firstName']
    @checkin.user_last_name = resp['user']['lastName']
    @checkin.user_photo = resp['user']['photo']
    @checkin.venue_id = resp['venue']['id']
    @checkin.stat_checkins_count = resp['venue']['stats']['checkinsCount']
    @checkin.stat_users_count = resp['venue']['stats']['usersCount']
    @checkin.message = resp.to_s
    @checkin.save


    #user = FoursquareUser.find_by_foursquare_id(checkin['user']['id'])
    #user.client.create_checkin_reply(checkin['id'], text: "hello world!")
    return head :ok
  end

  def index
    @checkins = Checkin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkins }
    end
  end
  
  def edit
    @checkin = Checkin.find(params[:id])
  end

  def show
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @checkin }
    end
  end
  def update
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      if @checkin.update_attributes(params[:checkin])
        format.html { redirect_to @checkin, notice: 'Checkin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

end
class ProfilesController < ApplicationController
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
    @fb_profiles = Profile.find(:all, :conditions => ["service = ? ", "FACEBOOK"])
    @fs_profiles = Profile.find(:all, :conditions => ["service = ? ", "FOURSQUARE"])
    @tw_profiles = Profile.find(:all, :conditions => ["service = ? ", "TWITTER"])
    @tw_master = Profile.find(:all, :conditions => ["service_id = ? ", "MASTER"]) 
    @ins_profiles = Profile.find(:all, :conditions => ["service = ? ", "INSTAGRAM"])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])

    if @profile.service == 'FACEBOOK'
        @insights = FbGraph::Page.new('QuincyBuiltSoftware').insights(
          :access_token => @profile.token
        )
        @me = FbGraph::User.me(@profile.token)
        @accounts = @me.accounts
        if @accounts.count > 0
          @accounts.each do |acc|
            name = acc.name
            token = acc.access_token
           # page_id = acc.id
          end
        end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
    @profile = Profile.new



    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])
    if @profile['service']='INSTAGRAM'
      # to update subscription on instagram.com we need to delete old subscription and create new one
    end  

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end
end

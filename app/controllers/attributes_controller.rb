class AttributesController < ApplicationController
  before_filter :authenticate_user!
 
  def index
    @attributes = current_user.attributes.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @attribute = current_user.attributes.find(params[:id])

    #respond_to do |format|
    #  format.html # show.html.erb
    #end
  end

  def new
    @attribute = current_user.attributes.new

    #respond_to do |format|
    #  format.html # new.html.erb
    #end
  end

  def edit
    @attribute = current_user.attributes.find(params[:id])
  end

  def create
    @attribute = current_user.attributes.new(params[:attribute])

    respond_to do |format|
      if @attribute.save
        format.html { redirect_to @attribute, notice: 'Attribute was successfully created.' }
        format.json { render json: @attribute, status: :created, location: @attribute }
      else
        format.html { render action: "new" }
        format.json { render json: @attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @attribute = current_user.attributes.find(params[:id])

    respond_to do |format|
      if @attribute.update_attributes(params[:attribute])
        format.html { redirect_to @attribute, notice: 'Attribute was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @attribute = current_user.attributes.find(params[:id])
    @attribute.destroy

    respond_to do |format|
      format.html { redirect_to attributes_url }
    end
  end
end

class InsightsController < ApplicationController
  # GET /insights
  # GET /insights.json
  def index
    @insights = Insight.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @insights }
    end
  end

  # GET /insights/1
  # GET /insights/1.json
  def show
    @insight = Insight.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @insight }
    end
  end

  # GET /insights/new
  # GET /insights/new.json
  def new
    @insight = Insight.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @insight }
    end
  end

  # GET /insights/1/edit
  def edit
    @insight = Insight.find(params[:id])
  end

  # POST /insights
  # POST /insights.json
  def create
    @insight = Insight.new(params[:insight])

    respond_to do |format|
      if @insight.save
        format.html { redirect_to @insight, notice: 'Insight was successfully created.' }
        format.json { render json: @insight, status: :created, location: @insight }
      else
        format.html { render action: "new" }
        format.json { render json: @insight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /insights/1
  # PUT /insights/1.json
  def update
    @insight = Insight.find(params[:id])

    respond_to do |format|
      if @insight.update_attributes(params[:insight])
        format.html { redirect_to @insight, notice: 'Insight was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @insight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insights/1
  # DELETE /insights/1.json
  def destroy
    @insight = Insight.find(params[:id])
    @insight.destroy

    respond_to do |format|
      format.html { redirect_to insights_url }
      format.json { head :no_content }
    end
  end
end

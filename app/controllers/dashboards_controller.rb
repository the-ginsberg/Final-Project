class DashboardsController < ApplicationController
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]
  before_action :set_dashboards, only: [:join]
  before_action :authenticate_user!
  before_action :generate_token, only: [:create]
  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = Dashboard.all
  end

  def search
    @dashboard = Dashboard.find_by(token: params[:search])
    @news_feed = NewsFeed.new
    render 'show'
  end


  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
    @news_feed = NewsFeed.new
    @upload = Upload.new
    @news_feeds = NewsFeed.all
    @uploads = Upload.all
  end

  # GET /dashboards/new
  def new
    @dashboard = Dashboard.new
  end

  # GET /dashboards/1/edit
  def edit
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    # render plain: params.to_json
    @dashboard = Dashboard.new(dashboard_params)
    @dashboard.set_user(current_user)
    @dashboard.token = @token

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboards/1
  # PATCH/PUT /dashboards/1.json
  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: 'Dashboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
        @dashboard = Dashboard.find(params[:id])
    end

    def generate_token
      @token = SecureRandom.uuid
    end

    def set_dashboards
      @dashboards = Dashboard.all
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def dashboard_params
      params.require(:dashboard).permit(:title, :token, :user_id, :dashboard_id)
    end
end

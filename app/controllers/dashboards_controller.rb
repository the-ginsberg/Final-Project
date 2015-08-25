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
    membership = @dashboard.dashboard_memberships
    cur_use_id = current_user.id
      if @dashboard == nil
        redirect_to dashboards_path
      elsif membership == nil
        @news_feed = NewsFeed.new
        @events_by_date = @dashboard.events.group_by(&:date)
        @date = params[:date] ? Date.parse(params[:date]) : Date.today
        join = DashboardMembership.create
        join.member_id = current_user.id
        join.dashboard_id = @dashboard.id
        join.save
        render 'show'
      elsif membership.find_by(member_id: cur_use_id) != nil
        @date = params[:date] ? Date.parse(params[:date]) : Date.today
        @events_by_date = @dashboard.events.group_by(&:date)
        render 'show'
      else
        @news_feed = NewsFeed.new
        @events_by_date = @dashboard.events.group_by(&:date)
        @date = params[:date] ? Date.parse(params[:date]) : Date.today
        join = DashboardMembership.create
        join.member_id = current_user.id
        join.dashboard_id = @dashboard.id
        join.save
        render 'show'
      end
  end


  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
    @news_feed = NewsFeed.new
    @event = Event.new
    @upload = Upload.new
    # @news_feeds = NewsFeed.all
    @last_three = NewsFeed.order("created_at DESC").limit(3).where(dashboard_id: @dashboard.id)
    @uploads = Upload.all
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events_by_date = @dashboard.events.group_by(&:date)
    @only_three = Event.order("created_at DESC").limit(3).where(dashboard_id: @dashboard.id)
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

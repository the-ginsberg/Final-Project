class NewsFeedsController < ApplicationController
  before_action :set_news_feed, only: [:show, :edit, :update, :destroy]
  before_action :set_dashboard, only: [:create, :new, :index]
  before_action :authenticate_user!


  # GET /news_feeds
  # GET /news_feeds.json
  def index
    @news_feeds = @dashboard.news_feeds
  end

  # GET /news_feeds/1
  # GET /news_feeds/1.json
  def show
  end

  # GET /news_feeds/new
  def new
    @news_feed = @dashboard.news_feeds.new
  end

  # GET /news_feeds/1/edit
  def edit
  end

  # POST /news_feeds
  # POST /news_feeds.json
  def create
    # render plain: params.to_json

    @news_feed = @dashboard.news_feeds.new(news_feed_params)

    respond_to do |format|
      if @news_feed.save
        format.html { redirect_to @news_feed, notice: 'Newsfeed was successfully created.' }
        format.json { render :show, status: :created, location: @news_feed }
      else
        format.html { render :new }
        format.json { render json: @news_feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_feeds/1
  # PATCH/PUT /news_feeds/1.json
  def update
    respond_to do |format|
      if @news_feed.update(news_feed_params)
        format.html { redirect_to @news_feed, notice: 'News feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @news_feed }
      else
        format.html { render :edit }
        format.json { render json: @news_feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_feeds/1
  # DELETE /news_feeds/1.json
  def destroy
    @news_feed.destroy
    respond_to do |format|
      format.html { redirect_to news_feeds_url, notice: 'News feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_news_feed
        @news_feed = NewsFeed.find(params[:id])
    end

    def set_dashboard
        @dashboard = Dashboard.find params[:dashboard_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_feed_params
      params.require(:news_feed).permit(:title, :body, :dashboard_id)
    end

end

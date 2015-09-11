class NewsFeedsController < ApplicationController
  before_action :set_news_feed, only: [:show, :edit, :update, :destroy]
  before_action :set_dashboard, only: [:new, :index]
  before_action :set_twilio_client, only: [:create]
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
    @news_feed = NewsFeed.new
  end

  # GET /news_feeds/1/edit
  def edit
  end

  # POST /news_feeds
  # POST /news_feeds.json
  def create
    # render plain: params.to_json

    @news_feed = NewsFeed.new(news_feed_params)
    @news_feed.dashboard_id = @news_feed[:dashboard_id]

    respond_to do |format|
      if @news_feed.save
        # Twilio
        @dashboard = Dashboard.find(params[:news_feed][:dashboard_id])
        @dashboard.members.each do |member|
          if member.phone_number != nil
            message = @client.account.messages.create(:body => "A new message has been posted in #{@dashboard.title}: Title: #{@news_feed.title} Announcement: #{@news_feed.body.truncate(140)}",
            :to => "+1#{member.phone_number}",
            :from => "+17548006045",
            )
          end
        end
        # Twilio End
        format.html { redirect_to @news_feed, notice: 'Announcement was successfully created.' }
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
        format.html { redirect_to @news_feed, notice: 'Announcement was successfully updated.' }
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
      format.html { redirect_to dashboard_path(@news_feed.dashboard), notice: 'News feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_news_feed
        @news_feed = NewsFeed.find(params[:id])
    end

    def set_dashboard
        @dashboard = Dashboard.find(params[:dashboard_id])
    end

    def set_twilio_client
      @client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_feed_params
      params.require(:news_feed).permit(:title, :body, :dashboard_id)
    end

end

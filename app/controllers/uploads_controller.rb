class UploadsController < ApplicationController

  before_action :set_dashboard, only: :index
  before_action :authenticate_user!

  def index
    @uploads = @dashboard.uploads.all.order(created_at: :asc).paginate(page: params[:page], per_page: 9)
  end

  def create
    # Make an object in your bucket for your upload
    obj = S3_BUCKET.objects[params[:file].original_filename]

    # Upload the file
    obj.write(
      file: params[:file],
      acl: :public_read
    )
    dashboard = Dashboard.find(params["dashboard_id"])
    # params[:dashboard_id].first.first.first(-1).last(-1).last(2).to_i
    # Create an object for the upload
    @upload = dashboard.uploads.new(
                          url: obj.public_url,
                          name: obj.key
                          )

    # Save the upload
    if @upload.save
      redirect_to dashboard_uploads_path(dashboard.id), success: 'File successfully uploaded'
    else
      flash.now[:notice] = 'There was an error'
      render :new
    end
  end


private


  def set_dashboard
    @dashboard = Dashboard.find params[:dashboard_id]
  end


end

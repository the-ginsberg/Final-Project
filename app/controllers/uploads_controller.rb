class UploadsController < ApplicationController

  before_action :set_dashboard, only: [:create, :new, :index]
  before_action :authenticate_user!

  def index
    @uploads = @dashboard.upload.all.order(created_at: :asc).paginate(page: params[:page], per_page: 9)
  end

  def create
    # Make an object in your bucket for your upload
    obj = S3_BUCKET.objects[params[:file].original_filename]

    # Upload the file
    obj.write(
      file: params[:file],
      acl: :public_read
    )

    # Create an object for the upload
    @upload = @dashboard.uploads.new(
                          url: obj.public_url,
                          name: obj.key
                          )

    # Save the upload
    if @upload.save
      redirect_to dashboard_path(params[:dashboard_id]), success: 'File successfully uploaded'
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

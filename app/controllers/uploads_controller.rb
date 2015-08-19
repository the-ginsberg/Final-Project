class UploadsController < ApplicationController

  def index
    @uploads = Upload.all.order(created_at: :asc).paginate(page: params[:page], per_page: 9)
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
    @uploads = Upload.new(
                          url: obj.public_url,
                          name: obj.key
                          )

    # Save the upload
    if @uploads.save
      redirect_to dashboard_path(params[:dashboard_id]), success: 'File successfully uploaded'
    else
      flash.now[:notice] = 'There was an error'
      render :new
    end
  end


end

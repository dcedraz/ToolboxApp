class EncoderController < ApplicationController
  def index
  end


  def upload
    if params[:userfile] && !params[:userfile].blank?
      file_data = uploads_params()
    else
      flash.now[:notice] = 'Please select a file first'
      render "index"
      #redirect_to :action => 'index'
      return
    end
    if file_data.respond_to?(:read)
      file_contents = file_data.read
      flash.now[:notice] = "File was successfully loaded."

    elsif file_data.respond_to?(:path)
      file_contents = File.read(file_data.path)
      flash.now[:notice] = "File was successfully loaded."
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end
    @input = file_contents
    render "index"
  end

  private

  # Only allow a list of trusted parameters through.
  def uploads_params
    params.require(:userfile)
  end

end

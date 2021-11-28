class EncoderController < ApplicationController
  def index
  end

  def upload
    if params[:userfile] && !params[:userfile].blank?
      file_data = uploads_params()
    else
      flash.now[:notice] = 'Please select a file first'
      render "index"
      # Tried with redirect_to but it didnt work
      #redirect_to action: 'index'
      return
    end

    @input = ""
    @output = ""

    File.foreach(file_data) do |line|
      if line.valid_encoding?
        @input << line.encode("UTF-8", invalid: :replace)
        @output = "No invalid characters"
      else
        @input << line.encode("UTF-8", invalid: :replace)
        @output << line.encode("UTF-8", invalid: :replace, replace: "ERROR")
      end
    end

    flash.now[:notice] = "File was successfully loaded."

    render "index"
  end

  private

  # Only allow a list of trusted parameters through.
  def uploads_params
    params.require(:userfile)
  end

end

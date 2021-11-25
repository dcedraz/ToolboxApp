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
    if file_data.respond_to?(:read)

      #@input = file_data.read
      @input = ""
      @output = ""
      File.foreach(file_data) { |line| @input << line}
      File.foreach(file_data) { |line| @output << line.encode("UTF-8", invalid: :replace, replace: "ERROR")}
      flash.now[:notice] = "File was successfully loaded."

    elsif file_data.respond_to?(:path)
      #@input = File.read(file_data.path)
      File.foreach(file_data) { |line| @input << line}
      File.foreach(file_data) { |line| @output << line.encode("UTF-8", invalid: :replace, replace: "ERROR")}
      flash.now[:notice] = "File was successfully loaded."
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end
    @output
    render "index"

  end

  private

  # Only allow a list of trusted parameters through.
  def uploads_params
    params.require(:userfile)
  end

end

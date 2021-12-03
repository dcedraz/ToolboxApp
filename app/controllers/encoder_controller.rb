class EncoderController < ApplicationController

  def index
  end

  def upload
    #Accepted file formats to be uploaded
    accepted_formats = %r{.*json.*|.*csv.*|.*txt.*}

    if params[:userfile] && !params[:userfile].blank?
      file_data = uploads_params()
    else
      flash.now[:notice] = 'Please select a file first'
      render "index"
      # Tried with redirect_to but it didnt work
      #redirect_to action: 'index'
      return
    end

    accepted_formats.match?(File.extname(file_data)) ? file_converter(file_data) : flash.now[:notice] = "Invalid file format. It only accepts .json, .csv, .txt."

    render "index"
  end

  def file_converter(file)

    @input = ""
    @output = ""
    invalid_chars = 0

    IO.foreach(file) do |line|

      detection = CharlockHolmes::EncodingDetector.detect(line)
      utf8_encoded_content = CharlockHolmes::Converter.convert line, detection[:encoding], 'UTF-8'
      @input << utf8_encoded_content
      @output << line.encode("UTF-8", invalid: :replace)

      invalid_chars += 1 if !(line.valid_encoding?)
    end
    flash.now[:notice] = "Found #{invalid_chars} invalid characters"

  end

  private

  # Only allow a list of trusted parameters through.
  def uploads_params
    params.require(:userfile)
  end

end

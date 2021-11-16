class EncoderController < ApplicationController
  def index
  end

  def uploads
    @result = verify(uploads_params)
  end

  def upload(userfile)
    uploaded_file = userfile
    File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'wb') do |file|
    file.write(uploaded_file.read)
    end
  end

  def verify(userfile)
    # Note: use form validation to ensure that
    # params[:uploaded_file] is not null
    file_data = userfile
    if file_data.respond_to?(:read)
      file_contents = file_data.read

    elsif file_data.respond_to?(:path)
      file_contents = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def uploads_params
    params.require(:userfile)
  end
end

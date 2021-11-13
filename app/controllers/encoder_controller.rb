class EncoderController < ApplicationController
  def index
  end

  def uploads
    upload(uploads_params)
  end

  def upload(userfile)
    uploaded_file = userfile
    File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'wb') do |file|
    file.write(uploaded_file.read)
    end
  end
  private

  # Only allow a list of trusted parameters through.
  def uploads_params
    params.require(:userfile)
  end
end

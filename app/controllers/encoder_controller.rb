class EncoderController < ApplicationController
  def index
  end

  def uploads
    upload
  end

  def upload
    uploaded_file = params[:userfile]
    File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'wb') do |file|
    file.write(uploaded_file.read)
    end
  end

end

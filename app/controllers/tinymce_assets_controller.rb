class TinymceAssetsController < ApplicationController
  def create
    # Take upload from params[:file] and store it somehow...
    # Optionally also accept params[:hint] and consume if needed
    image = Image.create(:file => params[:file])
    params.permit(:file, :alt, :hint)
 
    render json: {
      image: {
        url: image.file.url
      }
    }, content_type: "text/html"
  end
end
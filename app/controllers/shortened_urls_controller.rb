class ShortenedUrlsController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def create
    result = UrlsRepository.create(params[:url])
    render json: result, status: :created
  end

  def show
    short_url = request.path
    full_url = UrlsRepository.find_by_short_url(short_url)
    if full_url 
      redirect_to full_url[:url]
    else
      head :not_found
    end
  end
end

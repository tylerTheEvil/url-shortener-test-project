class ShortenedUrlsController < ApplicationController
  def create
    result = UrlsRepository.create(params[:url])
    render json: result, status: :created
  end
end

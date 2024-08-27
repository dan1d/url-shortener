class UrlsController < ApplicationController

  def index
    @url = Url.top_100
    render json: @url
  end

  def show
    @url = Url.find(params[:id])
    @url.increment_visits!
    redirect_to @url.source_url, allow_other_host: true
  end

  def create
    @url = Url.find_or_create_by(source_url: url_params[:url])
    render json: @url, status: :created
  end

  private

  def url_params
    params.permit(:url)
  end
end
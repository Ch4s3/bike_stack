class Api::SpotsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def new
    @lockup = LockUp.new
  end

  def show
  end

  def create
    @lockup = LockUp.create(lockup_params)
  end

  def index
    @spots = LockUp.all
    render json: @spots.to_json
  end

  def find
    lat = lockup_params[:lat]
    lon = lockup_params[:lon]
    rad = lockup_params[:rad] || 0.1

    @results = LockUp.near([lat, lon], rad)

    respond_to do |format|
      format.json { render json: @results }
    end
  end

  private
  def lockup_params
    params.require(:lock_up).permit(:name, :lat, :lon, :rad, :description, :capacity)
  end
end

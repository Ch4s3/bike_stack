class LockUpController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :except => [:submit]
  def show
  end

  def create
  end

  def submit
    if params.present?
      name = params["name"]
      lat = params["lat"]
      lon = params["lon"]

      LockUp.create(name: name, lat: lat, lon: lon)
    end
  end

  def index
    @spots = LockUp.all
  end

  def spots
    @spots = LockUp.all
    respond_to do |format|
      format.html  
      format.json  { render json: @spots }
    end

  end
end

class LockUpsController < ApplicationController
  def new
    @lockup = LockUp.new
  end

  def show
    @spot = LockUp.find(params[:id])

  end

  def create
    @spot = LockUp.create(lockup_params)

    if @spot.save
      redirect_to root_path, :notice => "Spot Saved"
    else
      redirect_to :back, :notice => "Spot Not Saved"
    end
  end

  def submit
    if lockup_params.present?
      LockUp.create(lookup_params)
    end
  end

  def find
    if params.present?
      lat = params["lat"]
      lon = params["lon"]
      rad = params["rad"] || 0.1

      @results = LockUp.near([lat, lon], rad)
    end

    respond_to do |format|
      format.html
    end
  end

  def index
    @spots = LockUp.all
  end

  private
  def lockup_params
      params.require(:lock_up).permit(:name, :lat, :lon, :description, :capacity)
  end
end

class LockUpsController < ApplicationController
  def new
    @lockup = LockUp.new
  end

  def show
    @lockup = LockUp.find(params[:id])
  end

  def edit
    @lockup = LockUp.find(params[:id])
  end

  def create
    @lockup = LockUp.create(lockup_params)

    if @lockup.save
      redirect_to root_path, :notice => "Spot saved."
    else
      redirect_to :back, :notice => "Spot Not Saced"
    end
  end

  def update
    @lockup = LockUp.find(params[:id])
    if @lockup.update_attributes(lockup_params)
      redirect_to root_path, :notice => "Spot updated."
    else
      redirect_to :back, :alert => "Unable to update spot."
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
      params.require(:lock_up).permit(:name, :lat, :lon, :description, :capacity, :photo)
  end
end

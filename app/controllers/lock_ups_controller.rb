class LockUpsController < ApplicationController
  def new
    @lockup = LockUp.new
  end

  def show
  end

  def create
    @spot = LockUp.create(lockup_params)

    if @spot.save
      redirect_to root_path, :notice => "Spot saved."
    else
      redirect_to :back, :notice => "Spot Not Saced"
    end
  end

  def submit
    if lockup_params.present?
      LockUp.create(lookup_params)
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

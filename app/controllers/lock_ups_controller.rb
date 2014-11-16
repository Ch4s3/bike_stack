class LockUpsController < ApplicationController
  skip_before_filter  :verify_authenticity_token, only: [:vote]
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
      redirect_to root_path, :notice => "Spot Saved."
    else
      redirect_to :back, :notice => "Spot Not Saved"
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

  def vote
    lock_up_id = vote_params[:lock_up_id]
    direction = vote_params[:direction]

    lock_up = LockUp.find(lock_up_id)

    if direction == "up"
      lock_up.liked_by current_user
    elsif direction == "down"
      lock_up.downvote_from current_user
    end

    tally_votes = lock_up.get_upvotes.size - lock_up.get_downvotes.size
    lock_up.update_column(:total_votes, tally_votes)

    respond_to do |format|
      format.json {render json: tally_votes }
    end
  end

  def index
    @spots = LockUp.all
  end

  private
  def lockup_params
      params.require(:lock_up).permit(:name, :lat, :lon, :description, :capacity, :photo)
  end

  def vote_params
    params.require(:vote).permit(:lock_up_id, :direction)
  end
end

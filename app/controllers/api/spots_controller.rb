class Api::SpotsController < ApplicationController
  include LockUpCollection
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
      format.json { render json: collection_to_json(@results) }
    end
  end

  def vote
    user = User.create(name: "user#{User.last.id+1}", email: "email#{User.last.id+1}@email.com", password: "12345678")
    lock_up_id = vote_params[:lock_up_id]
    direction = vote_params[:direction]

    lock_up = LockUp.find(lock_up_id)
    if direction == "up"
      lock_up.liked_by User.first
    elsif direction == "down"
      lock_up.downvote_from User.first
    end

    tally_votes = lock_up.get_upvotes.size - lock_up.get_downvotes.size
    lock_up.update_column(:total_votes, tally_votes)

    respond_to do |format|
      format.json { render json: tally_votes }
    end

  end

  private
  def lockup_params
    params.require(:lock_up).permit(:name, :lat, :lon, :rad, :description, :capacity, :photo)
  end

  def vote_params
    params.require(:vote).permit(:lock_up_id, :direction)
  end
end

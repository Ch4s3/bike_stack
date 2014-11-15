module API
  class SpotsController < ApplicationController
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
      respond_to do |format|
        format.json  { render json: @spots }
      end
    end

    private
    def lockup_params
        params.require(:lock_up).permit(:name, :lat, :lon, :description, :capacity)
    end
  end
end
class VisitorsController < ApplicationController

  def index
    # gon.lockups = LockUp.all.map(&:attributes)
    gon.lockups = LockUp.all.map{|s| s.to_json_with_photo_url_thumb}
    gon.user_signed_in = user_signed_in?
  end

end

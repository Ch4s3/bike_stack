class VisitorsController < ApplicationController

  def index
    gon.lockups = LockUp.all.map(&:attributes)
  end

end

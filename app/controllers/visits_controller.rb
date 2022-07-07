class VisitsController < ApplicationController

  def create
    @visit = Buddy.new
    @visit.user = current_user
    if @visit.save
      redirect_to visit_path(@visit)
    else
      render :new
    end
  end

end

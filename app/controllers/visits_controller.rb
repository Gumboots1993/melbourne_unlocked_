class VisitsController < ApplicationController

  def create
    @visit = Visit.new
    @visit.lock_id = params[:lock_id]
    @visit.unlocked_date = DateTime.now()
    @visit.user = current_user
    if @visit.save
      redirect_to lock_path(@visit.lock_id)
    else
      render :new
    end
  end

end

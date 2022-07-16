class VisitsController < ApplicationController

  def create
    @visit = Visit.new
    @visit.lock_id = params[:lock_id]
    @visit.unlocked_date = DateTime.now()
    @visit.user = current_user
    if @visit.save
      redirect_to lock_visit_path(@visit.lock_id, @visit)
    else
      render :new
    end
  end

  def show
    @visit = Visit.find(params[:id])
  end

end

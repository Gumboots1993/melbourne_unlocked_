class VisitsController < ApplicationController

  def create
    @visit = Visit.new
    @visit.lock_id = params[:lock_id]
    @visit.unlocked_date = DateTime.now()
    @visit.user = current_user
    if @visit.save
      redirect_to visit_path(@visit)
    else
      render :new
    end
  end

  def show
    @visit = Visit.find(params[:id])
    @review = Review.new
  end

  def add_photo
    @visit = Visit.find(params[:id])
  end

  def update
    @visit = Visit.find(params[:id])
    if @visit.update(visit_params)
        redirect_to lock_path(@visit.lock)
      else
        render :new
      end
  end

  private

  def visit_params
    params.require(:visit).permit(:photo)
  end
end

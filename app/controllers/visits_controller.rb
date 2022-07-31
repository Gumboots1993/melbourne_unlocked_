class VisitsController < ApplicationController

  def create
    @visit = Visit.new
    @visit.lock_id = params[:lock_id]
    @visit.unlocked_date = DateTime.now()
    @visit.user = current_user
    if @visit.save
      @user = current_user
      @user.level = levels(@user)
      @user.save
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

  def levels(user)
    visits = user.visits.count
    case visits
    when 0..4
      "LVL 0 NOVICE"
    when 5..9
      "LVL 1 LEARNER"
    when 10..19
      "LVL 2 EXPERT"
    when 20..29
      "LVL 3 MASTER"
    when 30..39
      "LVL 4 DIVINE"
    else
      "LVL 5 SUPREME"
    end
  end

end

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

  def levels(visits)
    case visits
    when 0..4
      @user.level = "LVL 0 NOVICE"
      @user.save
      "LVL 0 NOVICE"
    when 5..9
      @user.level = "LVL 1 LEARNER"
      @user.save
      "LVL 1 LEARNER"
    when 10..19
      @user.level = "LVL 2 EXPERT"
      @user.save
      "LVL 2 EXPERT"
    when 20..29
      @user.level = "LVL 3 MASTER"
      @user.save
      "LVL 3 MASTER"
    when 30..39
      @user.level = "LVL 4 DIVINE"
      @user.save
      "LVL 4 DIVINE"
    else
      @user.level = "LVL 5 SUPREME"
      @user.save
      "LVL 5 SUPREME"
    end
  end

end

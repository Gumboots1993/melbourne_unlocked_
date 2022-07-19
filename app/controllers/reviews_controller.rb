class ReviewsController < ApplicationController
  before_action :set_visit

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.visit = set_visit
    @review.save
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_visit
    @Visit = Visit.find(params[:visit_id])
  end

end

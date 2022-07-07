class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to review_path(@review)
    else
      render :new
    end
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

end

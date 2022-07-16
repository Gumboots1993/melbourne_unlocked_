class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def profile
    @user = User.find_by(username: params[:username])
    @user_visits = @user.visits
    @locks = Lock.all
  end

  def show
  end

  def leaderboard
    @users = User.all
    @top_one = @users.max_by(1) { |user| user.visits.size }
    @leaderboard_two = @users.max_by(2) { |user| user.visits.size }
    @leaderboard_three = @users.max_by(3) { |user| user.visits.size }
    @leaderboard_ten = @users.max_by(10) { |user| user.visits.size }
    @top_two = @leaderboard_two.drop(1)
    @top_three = @leaderboard_three.drop(2)
    @top_ten = @leaderboard_ten.drop(3)
    @locks = Lock.all
  end

end

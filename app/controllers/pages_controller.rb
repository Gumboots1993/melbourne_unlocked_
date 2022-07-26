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
    @leaderboard_ten = @users.max_by(10) { |user| user.visits.size }
    @top_one = @leaderboard_ten.first
    @top_two = @leaderboard_ten.second
    @top_three = @leaderboard_ten.third
    @top_ten = @leaderboard_ten.drop(3)
    @locks = Lock.all
    @counter = 3
  end

end

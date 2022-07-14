class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def profile
    @user = current_user
    @user_visits = @user.visits
    @locks = Lock.all
  end

  def show
  end

  def leaderboard
    @users = User.all
    @top_3 = @users.max_by(3) { |user| user.visits.size }
    @top_10 = @users.max_by(10) { |user| user.visits.size }
    @locks = Lock.all
  end

end

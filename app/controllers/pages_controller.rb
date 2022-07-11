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
  end


end

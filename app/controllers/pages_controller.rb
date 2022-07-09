class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def profile
    @visits = Visit.all
    @user = current_user
  end

  def show
  end

  def leaderboard
  end


end

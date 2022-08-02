class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def profile
    @user = User.find_by(username: params[:username])
    @user_visits = @user.visits
    @locks = Lock.all
    @lvl = levels(@user_visits.count)
    @progress = level_progress(@user_visits.count, @lvl)
    @locks_left = how_many_left(@user_visits.count, @lvl)
    @user.level = levels(@user_visits)
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

  def levels(visits)
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

  def level_progress(visits, lvl)
    how_many = how_many_left(visits, lvl)
    "#{how_many[2]}%"
  end

  def how_many_left(visits, lvl)
    case lvl
    when "LVL 0 NOVICE"
      [5 - visits, "LVL 1 LEARNER", 100 - ((5 - visits)/5.to_f*100)]
    when "LVL 1 LEARNER"
      [10 - visits, "LVL 2 EXPERT", 100 - ((10 - visits)/10.to_f*100)]
    when "LVL 2 EXPERT"
      [20 - visits, "LVL 3 MASTER", 100 - ((20 - visits)/10.to_f*100)]
    when "LVL 3 MASTER"
      [30 - visits, "LVL 4 DIVINE", 100 - ((30 - visits)/10.to_f*100)]
    when "LVL 4 DIVINE"
      [40 - visits, "LVL 5 SUPREME", 100 - ((40 - visits)/10.to_f*100)]
    else
      [0, "infinity & beyond...", 100]
    end
  end
end

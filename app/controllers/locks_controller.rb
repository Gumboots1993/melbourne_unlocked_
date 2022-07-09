class LocksController < ApplicationController
  def index
    @locks = Lock.all
    @markers = @locks.geocoded.map do |lock|
      {
        lat: lock.latitude,
        lng: lock.longitude,
        info_window: render_to_string(partial: "info_window", locals: { lock: lock })
      }
    end
  end

  def show
    @lock = Lock.find(params[:id])
  end

  def new
    @lock = Lock.new
  end

  def create
    @lock = Lock.new(lock_params)
    # @lock.user = current_user
    if @lock.save
      redirect_to lock_path(@lock)
    else
      render :new
    end
  end

  def photo
  end

  def accept
  end

  def decline
  end

  private

  def lock_params
    params.require(:lock).permit(:name, :description, :address, :image, :special_content, :lock_type, :status)
  end

end

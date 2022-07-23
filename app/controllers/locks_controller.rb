class LocksController < ApplicationController
  def index
    @all_locks = Lock.where(status: "Accepted")

    @is_redirect = false

    if params[:query].present?
      @locks = @all_locks.search_by_all(params[:query])
      if @locks === []
        redirect_to root_path, notice: "Sorry!! No search results found :("
      end
    else
      @locks = @all_locks
    end

    @markers = @locks.geocoded.map do |lock|
      {
        lat: lock.latitude,
        lng: lock.longitude,
        info_window: render_to_string(partial: "info_window", locals: { lock: lock }),
        image_url: Visit.where(user_id: current_user, lock_id: lock.id).exists? ? "data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg id='Layer_2' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 76.11 76.11'%3E%3Cdefs%3E%3Cstyle%3E.cls-1,.cls-2%7Bfill:%23fff;%7D.cls-3%7Bfill:%23085b56;%7D.cls-4%7Bfill:url(%23Orange__Yellow-2);%7D.cls-5%7Bfill:%23d4e7e5;%7D.cls-6%7Bfill:%2300a79d;%7D.cls-7%7Bfill:url(%23linear-gradient);%7D.cls-2%7Bstroke:url(%23Orange__Yellow);stroke-miterlimit:10;stroke-width:6px;%7D%3C/style%3E%3ClinearGradient id='Orange__Yellow' x1='0' y1='38.06' x2='76.11' y2='38.06' gradientTransform='matrix(1, 0, 0, 1, 0, 0)' gradientUnits='userSpaceOnUse'%3E%3Cstop offset='0' stop-color='%23fff33b'/%3E%3Cstop offset='.04' stop-color='%23fee62d'/%3E%3Cstop offset='.12' stop-color='%23fdd51b'/%3E%3Cstop offset='.2' stop-color='%23fdca0f'/%3E%3Cstop offset='.28' stop-color='%23fdc70c'/%3E%3Cstop offset='.67' stop-color='%23f3903f'/%3E%3Cstop offset='.89' stop-color='%23ed683c'/%3E%3Cstop offset='1' stop-color='%23e93e3a'/%3E%3C/linearGradient%3E%3ClinearGradient id='Orange__Yellow-2' x1='18.64' y1='50.8' x2='56.77' y2='50.8' xlink:href='%23Orange__Yellow'/%3E%3ClinearGradient id='linear-gradient' x1='38.07' y1='35.06' x2='38.07' y2='46.78' gradientTransform='matrix(1, 0, 0, 1, 0, 0)' gradientUnits='userSpaceOnUse'%3E%3Cstop offset='0' stop-color='%23fff33b'/%3E%3Cstop offset='.04' stop-color='%23fee62d'/%3E%3Cstop offset='.12' stop-color='%23fdd51b'/%3E%3Cstop offset='.2' stop-color='%23fdca0f'/%3E%3Cstop offset='.28' stop-color='%23fdc70c'/%3E%3Cstop offset='.67' stop-color='%23f3903f'/%3E%3Cstop offset='.84' stop-color='%23ed683c'/%3E%3Cstop offset='.96' stop-color='%23c54c29'/%3E%3C/linearGradient%3E%3C/defs%3E%3Cg id='Layer_1-2'%3E%3Ccircle class='cls-2' cx='38.06' cy='38.06' r='35.06'/%3E%3Cpath class='cls-4' d='M41.39,66.16c-2.8,.51-4.28,.43-7.37,0-3.83-.53-11.61-4.12-13.78-8.05l-1.6-17.59s.06-.04,.07-.15c.56-4.03,3.64-5.54,3.37-5.25-2.63,2.78-.22,4.67-.16,4.74,3.44,4.17,11.17,2.34,16.73-.57s14.96-6.88,18.13,.74c.01,.03,0,0,0,0l-1.6,18.08c-2.15,4.18-9.98,7.36-13.78,8.05Z'/%3E%3Cellipse class='cls-3' cx='37.77' cy='52.4' rx='2.59' ry='2.63'/%3E%3Cpolygon class='cls-3' points='36.11 54.24 39.09 54.24 40.04 59.8 35.28 59.8 36.11 54.24'/%3E%3Cpath class='cls-7' d='M21.25,41.97c-1.47-1.13-2.24-2.19-1.71-3.99,.2-.7,.61-1.42,1.04-1.89,.62-.69,1.66-1.15,1.52-1-.71,.77-.81,1.06-1,1.45-.33,.68-.32,1.47-.02,2.03,2.36,4.44,11.67,4.48,17.72,.72,6.49-4.03,15.36-6.21,17.97,.74,.01,.03-.02,.14-.03,.16-.36,.46-.83,1.13-1.85,1.66-6.92,3.59-22.13,8.94-33.63,.11Z'/%3E%3Cpath class='cls-6' d='M52.24,30.15h-1.88c-1.45-.41-1.3-1.85-1.3-3.14v-3.64c-.06-2.45-.44-3.6-1.26-3.67-1.49-.14-1.63,1.62-2.45,5.25-1.26,5.58-9.93,6.92-12.93,1.04l-.1-.18c-1.4-2.45-.25-5.7-2.66-5.49-1.65,.14-1.39,3.25-1.51,4.72,0,.13-.02,.26-.02,.39l-.04,11.41c-.28,1.68,.14,2.94-2.08,2.88,0,0-.91-.38-1.22-.48-1.51-.5-1.9-1.54-1.9-2.4v-15.19c0-2.61-.18-5.98,1.44-7.6,1.99-1.98,5.65-2.44,8.13-1.36l.11,.05c.36,.16,.71,.38,1,.66,4.04,4.08,2.33,10.39,5.18,10.52,2.83,.14,1.56-7.75,6.69-11.1h0c2.78-1.31,6.05-.61,8.08,1.88,1.27,1.57,.84,4.66,.84,6.93v6.19c0,1.29-.94,2.34-2.1,2.34Z'/%3E%3Cpath class='cls-1' d='M27.99,18.93l.73-.43v.02c-1.2,1.45-1.44,1.47-1.61,4.92v14.38c0,.12-.13,.13-.28,.09h0c-.3-.05-.51-.26-.51-.5v-14.74c0-.78,.13-1.56,.4-2.31h0c.2-.58,.66-1.08,1.27-1.44Z'/%3E%3Cpath class='cls-1' d='M52.18,13.97l.26,.37c.86,1.23,1.34,1.85,1.34,3.59v10.36h0c0,.39-.36,.93-.8,1.1v-9.26c0-3.98-.12-4.68-.73-5.89l-.07-.28Z'/%3E%3Cpath class='cls-5' d='M43.34,15.34c-.1,.3-.62,1.36-1.05,3.22l-1.17,3.95c-.41,1.31-1.25,2.05-2.41,2.81h0c1.67-.14,3.06-1.3,3.47-2.89l.7-2.38c.32-2.04,0-3.68,.46-4.71Z'/%3E%3Cellipse class='cls-3' cx='50.09' cy='38.9' rx='3.04' ry='.97'/%3E%3C/g%3E%3C/svg%3E" : ""
      }
    end
  end

  def show
    @lock = Lock.find(params[:id])
    @current_user_visit = Visit.where(user_id: current_user, lock_id: @lock.id)
    @review = Review.new
    @visit = Visit.where(user_id: current_user, lock_id: @lock.id).first
    @marker = [{
      lat: @lock.latitude,
      lng: @lock.longitude,
      image_url: Visit.where(user_id: current_user, lock_id: @lock.id).exists? ? "data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg id='Layer_2' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 76.11 76.11'%3E%3Cdefs%3E%3Cstyle%3E.cls-1,.cls-2%7Bfill:%23fff;%7D.cls-3%7Bfill:%23085b56;%7D.cls-4%7Bfill:url(%23Orange__Yellow-2);%7D.cls-5%7Bfill:%23d4e7e5;%7D.cls-6%7Bfill:%2300a79d;%7D.cls-7%7Bfill:url(%23linear-gradient);%7D.cls-2%7Bstroke:url(%23Orange__Yellow);stroke-miterlimit:10;stroke-width:6px;%7D%3C/style%3E%3ClinearGradient id='Orange__Yellow' x1='0' y1='38.06' x2='76.11' y2='38.06' gradientTransform='matrix(1, 0, 0, 1, 0, 0)' gradientUnits='userSpaceOnUse'%3E%3Cstop offset='0' stop-color='%23fff33b'/%3E%3Cstop offset='.04' stop-color='%23fee62d'/%3E%3Cstop offset='.12' stop-color='%23fdd51b'/%3E%3Cstop offset='.2' stop-color='%23fdca0f'/%3E%3Cstop offset='.28' stop-color='%23fdc70c'/%3E%3Cstop offset='.67' stop-color='%23f3903f'/%3E%3Cstop offset='.89' stop-color='%23ed683c'/%3E%3Cstop offset='1' stop-color='%23e93e3a'/%3E%3C/linearGradient%3E%3ClinearGradient id='Orange__Yellow-2' x1='18.64' y1='50.8' x2='56.77' y2='50.8' xlink:href='%23Orange__Yellow'/%3E%3ClinearGradient id='linear-gradient' x1='38.07' y1='35.06' x2='38.07' y2='46.78' gradientTransform='matrix(1, 0, 0, 1, 0, 0)' gradientUnits='userSpaceOnUse'%3E%3Cstop offset='0' stop-color='%23fff33b'/%3E%3Cstop offset='.04' stop-color='%23fee62d'/%3E%3Cstop offset='.12' stop-color='%23fdd51b'/%3E%3Cstop offset='.2' stop-color='%23fdca0f'/%3E%3Cstop offset='.28' stop-color='%23fdc70c'/%3E%3Cstop offset='.67' stop-color='%23f3903f'/%3E%3Cstop offset='.84' stop-color='%23ed683c'/%3E%3Cstop offset='.96' stop-color='%23c54c29'/%3E%3C/linearGradient%3E%3C/defs%3E%3Cg id='Layer_1-2'%3E%3Ccircle class='cls-2' cx='38.06' cy='38.06' r='35.06'/%3E%3Cpath class='cls-4' d='M41.39,66.16c-2.8,.51-4.28,.43-7.37,0-3.83-.53-11.61-4.12-13.78-8.05l-1.6-17.59s.06-.04,.07-.15c.56-4.03,3.64-5.54,3.37-5.25-2.63,2.78-.22,4.67-.16,4.74,3.44,4.17,11.17,2.34,16.73-.57s14.96-6.88,18.13,.74c.01,.03,0,0,0,0l-1.6,18.08c-2.15,4.18-9.98,7.36-13.78,8.05Z'/%3E%3Cellipse class='cls-3' cx='37.77' cy='52.4' rx='2.59' ry='2.63'/%3E%3Cpolygon class='cls-3' points='36.11 54.24 39.09 54.24 40.04 59.8 35.28 59.8 36.11 54.24'/%3E%3Cpath class='cls-7' d='M21.25,41.97c-1.47-1.13-2.24-2.19-1.71-3.99,.2-.7,.61-1.42,1.04-1.89,.62-.69,1.66-1.15,1.52-1-.71,.77-.81,1.06-1,1.45-.33,.68-.32,1.47-.02,2.03,2.36,4.44,11.67,4.48,17.72,.72,6.49-4.03,15.36-6.21,17.97,.74,.01,.03-.02,.14-.03,.16-.36,.46-.83,1.13-1.85,1.66-6.92,3.59-22.13,8.94-33.63,.11Z'/%3E%3Cpath class='cls-6' d='M52.24,30.15h-1.88c-1.45-.41-1.3-1.85-1.3-3.14v-3.64c-.06-2.45-.44-3.6-1.26-3.67-1.49-.14-1.63,1.62-2.45,5.25-1.26,5.58-9.93,6.92-12.93,1.04l-.1-.18c-1.4-2.45-.25-5.7-2.66-5.49-1.65,.14-1.39,3.25-1.51,4.72,0,.13-.02,.26-.02,.39l-.04,11.41c-.28,1.68,.14,2.94-2.08,2.88,0,0-.91-.38-1.22-.48-1.51-.5-1.9-1.54-1.9-2.4v-15.19c0-2.61-.18-5.98,1.44-7.6,1.99-1.98,5.65-2.44,8.13-1.36l.11,.05c.36,.16,.71,.38,1,.66,4.04,4.08,2.33,10.39,5.18,10.52,2.83,.14,1.56-7.75,6.69-11.1h0c2.78-1.31,6.05-.61,8.08,1.88,1.27,1.57,.84,4.66,.84,6.93v6.19c0,1.29-.94,2.34-2.1,2.34Z'/%3E%3Cpath class='cls-1' d='M27.99,18.93l.73-.43v.02c-1.2,1.45-1.44,1.47-1.61,4.92v14.38c0,.12-.13,.13-.28,.09h0c-.3-.05-.51-.26-.51-.5v-14.74c0-.78,.13-1.56,.4-2.31h0c.2-.58,.66-1.08,1.27-1.44Z'/%3E%3Cpath class='cls-1' d='M52.18,13.97l.26,.37c.86,1.23,1.34,1.85,1.34,3.59v10.36h0c0,.39-.36,.93-.8,1.1v-9.26c0-3.98-.12-4.68-.73-5.89l-.07-.28Z'/%3E%3Cpath class='cls-5' d='M43.34,15.34c-.1,.3-.62,1.36-1.05,3.22l-1.17,3.95c-.41,1.31-1.25,2.05-2.41,2.81h0c1.67-.14,3.06-1.3,3.47-2.89l.7-2.38c.32-2.04,0-3.68,.46-4.71Z'/%3E%3Cellipse class='cls-3' cx='50.09' cy='38.9' rx='3.04' ry='.97'/%3E%3C/g%3E%3C/svg%3E" : ""
    }]
    @reviews = all_reviews_for_lock(@lock)
    @photos = all_photos_for_lock(@lock)
  end

  def new
    @lock = Lock.new
  end

  def create
    @lock = Lock.new(lock_params)
    if @lock.save
      if current_user.admin?
        redirect_to lock_path(@lock)
      else
        redirect_to locks_new_lock_request_path
      end
    else
      render :new
    end
  end

  def new_lock
  end

  def view_requests
    @locks = Lock.where(status: "Pending")
  end

  def photo
  end

  def accept
    @lock = Lock.find(params[:id])
    @lock.status = "Accepted"
    if @lock.save
      redirect_to root_path
    else
      render :new
    end
  end

  def decline
    @lock = Lock.find(params[:id])
    @lock.status = "Declined"
    if @lock.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def lock_params
    params.require(:lock).permit(:name, :description, :address, :photo, :special_content, :lock_type, :status)
  end

  def all_reviews_for_lock(lock)
    reviews = []
    Visit.where(lock_id: lock.id).each do |visit|
      if Review.where(visit_id: visit.id).exists?
        reviews.push(Review.where(visit_id: visit.id).first)
      end
    end
    reviews
  end

  def all_photos_for_lock(lock)
    photos = []
    Visit.where(lock_id: lock.id).each do |visit|
      if visit.photo.attached? == true
        photos.push(visit.photo)
      end
    end
    photos
  end

end

# 1. Update index page to only show approved
# 2. create admin only page to view pending
# 3. Dashboard controller for admins

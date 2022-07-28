class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications
    current_user.notifications.each do |notification|
      if notification.type == 'LockSuggestionNotification'
        notification.mark_as_read!
      end
    end

  end

end

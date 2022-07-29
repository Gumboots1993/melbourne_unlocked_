class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.newest_first
    @notifications.each do |notification|
      if notification.type == 'LockSuggestionNotification'
        notification.mark_as_read!
      end
      if notification.type == 'WelcomeNotification'
        notification.mark_as_read!
      end
    end

  end

end

# To deliver this notification:
#
# LockSuggestionNotification.with(post: @post).deliver_later(current_user)
# LockSuggestionNotification.with(post: @post).deliver(current_user)

class LockSuggestionNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :lock

  # Define helper methods to make rendering easier.
  #
  def message
    t(".message")
  end
  #
  def url
    lock_path(params[:lock])
  end
end

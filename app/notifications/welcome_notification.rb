# To deliver this notification:
#
# WelcomeNotification.with(post: @post).deliver_later(current_user)
# WelcomeNotification.with().deliver(current_user)

class WelcomeNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :user

  # Define helper methods to make rendering easier.

  def user
    User.find(params[:user])
  end
  #
  def message
    t(".message")
  end

  def url
    root_path
  end
end

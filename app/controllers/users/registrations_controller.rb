class Users::RegistrationsController < Devise::RegistrationsController
  layout "application"

  def create
    super do |user|
      if user.persisted?
        WelcomeNotification.with(user: user.id).deliver(user)
      end
    end
  end
end

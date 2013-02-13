class Notify < ActionMailer::Base
  default from: "noreply@launchgator.com"

  def update_notification(user)
    mail(:to => user.email, :subject => "Registered")
  end
end

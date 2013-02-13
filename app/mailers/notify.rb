class Notify < ActionMailer::Base
  default from: "noreply@launchgator.com"

  def registration_confirmation(user)
    mail(:to => user.email, :subject => "Registered")
  end
end

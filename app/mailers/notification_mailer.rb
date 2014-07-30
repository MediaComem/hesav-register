class NotificationMailer < ActionMailer::Base
  default from: "admission@hesav.ch"

  def error_email(msg,params)
    @message  = msg
    @params = params
    mail(to: "julien.le-glaunec@heig-vd.ch", subject: 'HESAV Payment : Error Report')
  end
  def success_email(registration)
    @registration  = registration
    mail(to: @registration.email, bcc: "julien.le-glaunec@heig-vd.ch", subject: "Confirmation d'inscription")
  end
end

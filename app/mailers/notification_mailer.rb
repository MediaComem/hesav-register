class NotificationMailer < ActionMailer::Base
  default from: "admission@hesav.ch"

  before_filter :init_values
  def init_values
    @super_admin = "julien.le-glaunec@heig-vd.ch"
    @admin = "phb@heig-vd.ch"
  end
  # after a sha calculation error => to super_admin
  def error_email(msg,params)
    @message = msg
    @params = params
    mail(to: @super_admin, subject: 'EPayment Proxy - Error Report')
  end
  # after a decline/cancel/exception => to admin
  def registration_not_completed(msg,params,registration)
    @message = msg
    @params = params
    @registration = registration
    mail(to: @admin, bcc: @super_admin, subject: "Gouveole - Problème d'inscription")
  end
  # after a successful (and definitive) registration
  def success_confirmed_email(registration)
    @registration = registration
    mail(to: @registration.email, bcc: @super_admin, subject: "Confirmation d'inscription à Gouveole")
  end
  # after a successful (but not definitive) registration
  def success_not_confirmed_email(registration)
    @registration = registration
    mail(to: @registration.email, bcc: @super_admin, subject: "Pré-confirmation d'inscription à Gouveole")
  end
end

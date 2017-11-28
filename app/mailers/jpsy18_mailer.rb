class Jpsy18Mailer < ActionMailer::Base
  default from: "admission@hesav.ch"
  before_filter :init_values

  def init_values

    # @super_admin = 'mathias.oberson@heig-vd.ch'
    @super_admin = "adrien.bigler@heig-vd.ch"
    # @super_admin = "julien.le-glaunec@heig-vd.ch"

  end

  def error_email(msg,params)

    @message  = msg
    @params = params
    mail(to: @super_admin, subject: 'HESAV Payment : Error Report')

  end

  def success_email(registration)

    @registration  = registration
    mail(to: @registration.email, bcc: @super_admin, subject: "Confirmation d'inscription")

  end

end

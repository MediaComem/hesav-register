class GouveoleMailer < ActionMailer::Base
  default from: "gouveole@heig-vd.ch"
  before_filter :init_values
  def init_values
    #@super_admin = "julien.le-glaunec@heig-vd.ch"
    #@admin = "phb@heig-vd.ch"
    @super_admin = "julien.le-glaunec@heig-vd.ch"
    @admin = "julien.le-glaunec@heig-vd.ch"
  end
  # after a successful (but not definitive) registration
  def success_not_confirmed_email(registration)
    @registration = registration
    mail(to: @registration.email, bcc: [@admin, @super_admin], subject: "Pré-confirmation d'inscription à Gouveole")
  end
end

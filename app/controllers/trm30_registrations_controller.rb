require 'httparty'
require 'trm30_csv_service'

class Trm30RegistrationsController < ApplicationController
	before_filter :init_values
  before_filter :authenticate, only: [:admin]

  def init_values

    #constants
    @event_name = 'trm30'
    @shop_id = 'trm30' # psy14dev / psy14
    @environment = 'prod' # test/prod
    @language = 'fr_FR'

    # layout
    self.class.layout('trm30')
  end

  def admin
    date_start = DateTime.new(2017,06,19,00,00)
    registrations = Trm30Registration.where("created_at > :date_start",{date_start: date_start}).order("created_at DESC").all
    @registrations = registrations
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
      format.csv {

        csv_string = Trm30Csv2Service.generate(registrations)

        send_data csv_string.encode("iso-8859-1", :invalid => :replace, :undef => :replace, :replace => "?"),
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=inscriptions.csv" 
      }
    end
  end

  def new
    event = Event.find_by_short_name!(@event_name)
    if event.open < DateTime.now && event.close > DateTime.now
      @registration = Trm30Registration.new
    else
      if event.open > DateTime.now
        flash.now[:info] = "The registration is not yet available."
      else
        flash.now[:info] = "The registration is not available anymore."
      end
      render "close"
    end
  end

  def create

    event = Event.find_by_short_name!(@event_name)
    @registration = Trm30Registration.new(post_params)
    @registration.environment = @environment
    @registration.language = @language
    @registration.event = event

    if (@registration.save)
      msg = "INFO :: Inscription"
      registration_ok(msg,@registration)
      render 'accepted'
    else
      flash.now[:notice_error] = "L'inscription n'a pas pu être effectuée. Veuillez réessayer s'il vous plaît."
      render "new"
    end

  end

  def accepted
  end

  def cgv
  end

  private

    def post_params
      params.require(:trm30_registration).permit(:last_name,:first_name,:city,:email,:street,:streetnumber,:npa,:employer,:team)
    end

    def registration_ok(msg,registration)
      logger.info msg
      flash.now[:notice_title] = "Merci, votre inscription a bien été enregistrée"
      flash.now[:notice] = "Un message automatique de confirmation vient d'être envoyé à votre adresse mail."
      Trm30Mailer.success_email(registration).deliver
    end

    def payment_not_accepted(msg,params)
      logger.error msg
      flash[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
      Trm30Mailer.error_email(msg,params).deliver
    end
  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
      username == "hesav" && password == "be2hax"
    end
  end
end

require 'httparty'
require 'auto17_csv_service'

class Auto17RegistrationsController < ApplicationController

  before_filter :init_values
  before_filter :authenticate, only: [:admin]

  def init_values

    #constants
    @event_name = 'auto17'
    @shop_id = 'auto17' # psy14dev / psy14
    @environment = 'test' # test/prod
    @language = 'fr_FR'

    # layout
    self.class.layout('auto17')
  end

  def admin
    date_start = DateTime.new(2017,06,19,00,00)
    registrations = Auto17Registration.where("created_at > :date_start AND payed",{date_start: date_start}).order("created_at DESC").all
    @registrations = registrations
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
      format.csv {

        csv_string = Auto17Csv2Service.generate(registrations)

        send_data csv_string.encode("iso-8859-1", :invalid => :replace, :undef => :replace, :replace => "?"),
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=inscriptions.csv" 
      }
    end
  end

  def new
    event = Event.find_by_short_name!(@event_name)
    if event.open < DateTime.now && event.close > DateTime.now
      @registration = Auto17Registration.new
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
    @registration = Auto17Registration.new(post_params)
    @registration.shopID = @shop_id
    @registration.environment = @environment
    @registration.language = @language
    @registration.payed = false
    @registration.event = event
    @amount = 0
    case @registration.type_price
    when "free"
      @registration.type_price = 'free'
      @registration.payed = true  
    when "normal"
      @registration.type_price = '140.00'
      @amount = 14000
    else
      @registration.type_price = '-1'
    end

    if (@registration.type_price != 'free' && @registration.save)
      begin
        charge = Stripe::Charge.create(
          :source  => params[:stripeToken],
          :amount      => @amount,
          :description => 'Inscription Journée scientifique sage-femme',
          :currency    => 'chf'
        )
        @registration.payed = true
        @registration.save
        msg = "INFO :: Inscription payante"
        registration_ok(msg,@registration)
        render 'accepted'
      end
    else
      if @registration.save && (@registration.type_price == "free")
        msg = "INFO :: Inscription sans frais"
        registration_ok(msg,@registration)
        render 'accepted'
      else
        flash.now[:notice_error] = "L'inscription n'a pas pu être effectuée. Veuillez réessayer s'il vous plaît."
        render "new"
      end
    end
    rescue Stripe::CardError => e
      flash.now[:error] = e.message
      render "new"
  end

  def accepted
  end

  def cgv
  end

  private

    def post_params
      params.require(:auto17_registration).permit(:last_name,:first_name,:type_price,:type_afternoon,:type_lunch,:type_morning,:city,:email,:street,:streetnumber,:npa,:employer,:job,:title,:stripeToken,:food,:translate)
    end

    def registration_ok(msg,registration)
      logger.info msg
      flash.now[:notice_title] = "Merci, votre inscription a bien été enregistrée"
      flash.now[:notice] = "Un message automatique de confirmation vient d'être envoyé à votre adresse mail."
      Auto17Mailer.success_email(registration).deliver
    end

    def payment_not_accepted(msg,params)
      logger.error msg
      flash[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
      Auto17Mailer.error_email(msg,params).deliver
    end
  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
      username == "hesav" && password == "be2hax"
    end
  end

end

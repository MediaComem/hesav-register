require 'httparty'
require 'symposium18_csv_service'

class Jpsy18RegistrationsController < ApplicationController

  before_filter :init_values
  before_filter :authenticate, only: [:admin]

  def init_values

    #constants
    @event_name = 'symposium18'
    @shop_id = 'symposium18'
    @environment = 'prod'
    @language = 'fr_FR'

    # layout
    self.class.layout('symposium')

  end

  def admin

    date_start = DateTime.new(2017, 12, 13, 14, 00)
    registrations = Symposium18Registration.where("created_at > :date_start AND payed", {date_start: date_start}).order("created_at DESC").all
    @registrations = registrations

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
      format.csv {

        csv_string = Symposium182CsvService.generate(registrations)

        send_data csv_string.encode("iso-8859-1", :invalid => :replace, :undef => :replace, :replace => "?"),
                  :type => 'text/csv; charset=iso-8859-1; header=present',
                  :disposition => "attachment; filename=inscriptions.csv"
      }
    end

  end

  def new

    event = Event.find_by_short_name!(@event_name)
    if event.open < DateTime.now && event.close > DateTime.now
      @registration = SymposiumRegistration.new
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
    @registration = SymposiumRegistration.new(post_params)
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
        @registration.type_price = '20.00'
        @amount = 2000
      else
        @registration.type_price = '-1'
    end

    if (@registration.type_price != 'free' && @registration.save)
      begin
        charge = Stripe::Charge.create(
          :source  => params[:stripeToken],
          :amount      => @amount,
          :description => "Inscription HESAV - Symposium sur l'assistance à mourir",
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
    params.require(:symposium18_registration).permit(:last_name, :first_name, :type_price, :type_choice, :city, :email, :street, :npa, :employer,:stripeToken)
  end

  def registration_ok(msg, registration)
    logger.info msg
    flash.now[:notice_title] = "Nous vous remercions de votre inscription."
    flash.now[:notice] = "Une confirmation email vous parviendra dans quelques minutes."
    Symposium18Mailer.success_email(registration).deliver
  end

  def payment_not_accepted(msg, params)
    logger.error msg
    flash[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
    Symposium18Mailer.error_email(msg, params).deliver
  end

  def accepted_with_error(msg, params)
    logger.error msg
    flash.now[:notice] = "L'administrateur a été informé et vous serez contacté prochainement."
    Symposium18Mailer.error_email(msg, getParams).deliver
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "hesav" && password == "be2hax"
    end
  end

end

require 'httparty'
require 'js16_csv_service'

class Js16RegistrationsController < ApplicationController

  before_filter :init_values
  before_filter :authenticate, only: [:admin]

  def init_values

    #constants
    @event_name = 'js16'
    @shop_id = 'js16dev' # js16dev / js16
    @environment = 'test' # test/prod
    @language = 'fr_FR'
    @ateliers = [
      ['VIEILLESSE ET MISE EN SENS DES PRATIQUES DE SOINS', 'Atelier 1'],
      ['DES NOUVEAUX AGES : VULNERABILITE ET MARGINALISATION', 'Atelier 2'],
      ['LIEUX OUVERTS, LIEUX FERMES : LE VIELLISSEMENT AU DEFI DES LIEUX DE VIE', 'Atelier 3']
    ]

    # layout
    self.class.layout('js16')

  end

  def admin

    date_start = DateTime.new(2016, 05, 02, 00, 00)
    registrations = Js16Registration.where("created_at > :date_start AND payed", {date_start: date_start}).order("created_at DESC").all
    @registrations = registrations

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
      format.csv {

        csv_string = Csv2Service.generate(registrations)

        send_data csv_string.encode("iso-8859-1", :invalid => :replace, :undef => :replace, :replace => "?"),
                  :type => 'text/csv; charset=iso-8859-1; header=present',
                  :disposition => "attachment; filename=inscriptions.csv"
      }
    end

  end

  def new

    event = Event.find_by_short_name!(@event_name)
    if event.open < DateTime.now && event.close > DateTime.now
      @registration = Js16Registration.new
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
    @registration = Js16Registration.new(post_params)
    @registration.shopID = @shop_id
    @registration.environment = @environment
    @registration.language = @language
    @registration.payed = false
    @registration.event = event
    case @registration.type_price
      when "free"
        @registration.type_price = 'free'
        @registration.payed = true
      when "normal"
        @registration.type_price = '100.00'
      when "reduced"
        @registration.type_price = '80.00'
      else
        @registration.type_price = '-1'
    end

    if @registration.save && (@registration.type_price != 'free')
      render 'hiddenform'
    else
      if @registration.save && (@registration.type_price == "free")
        msg = "INFO :: Inscription sans frais"
        registration_ok(msg, @registration)
        render 'accepted'
      else
        flash.now[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
        render "new"
      end
    end

  end

  def accepted

    getParams = request.query_parameters

    if !sha_valid(getParams)
      msg = "PostFinance :: Accept Action :: The SHA-OUT is not valid"
      accepted_with_error(msg, getParams)
      render :error
    else
      if getParams["orderID"] != nil
        # La reference de paiement Postfinance. Attention, cette reference est une concatenation du shopID et de l’orderID transmis precedemment (ex. myShopID_myOrderID)
        orderID_back = getParams["orderID"].split('_')[1]
        registration = Js16Registration.find_by_id(orderID_back)
        if registration == nil
          msg = "PostFinance :: Accept Action :: Not Found => (The registration with the id #"+orderID_back+" has not been found)"
          accepted_with_error(msg, getParams)
          render :error
        else
          registration.payed = true
          registration.save
          msg = "PostFinance :: Accept Action :: The registration with the id #"+orderID_back+" has been payed"
          registration_ok(msg, registration)
        end
      else
        msg = "PostFinance :: Accept Action :: orderID return is null"
        accepted(msg, getParams)
        render :error
      end
    end

  end

  def decline

    getParams = request.query_parameters
    msg = 'PostFinance :: Decline Action'
    payment_not_accepted(msg, getParams)
    redirect_to action: "new"

  end

  def cancel

    getParams = request.query_parameters
    msg = 'PostFinance :: Cancel Action'
    payment_not_accepted(msg, getParams)
    redirect_to action: "new"

  end

  def exception

    getParams = request.query_parameters
    msg = 'PostFinance :: Exception Action'
    payment_not_accepted(msg, getParams)
    redirect_to action: "new"

  end

  def cgv
  end

  private

  def post_params
    params.require(:js16_registration).permit(:last_name, :first_name, :type_price, :type_choice, :city, :email, :street, :npa, :employer)
  end

  def sha_valid(params)

    sha_out = APP_CONFIG["sha_out_test"]
    if @environment == 'prod'
      sha_out = APP_CONFIG["sha_out_prod"]
    end

    # List of parameters to be included in SHA OUT calculation (e-commerce Advanced Documentation)
    sha_out_params = ["AAVADDRESS", "AAVCHECK", "AAVZIP", "ACCEPTANCE", "ALIAS", "AMOUNT", "BRAND", "CARDNO", "CCCTY", "CN", "COMPLUS", "CURRENCY", "CVCCHECK", "DCC_COMMPERCENTAGE", "DCC_CONVAMOUNT", "DCC_CONVCCY", "DCC_EXCHRATE", "DCC_EXCHRATESOURCE", "DCC_EXCHRATETS", "DCC_INDICATOR", "DCC_MARGINPERCENTAGE", "DCC_VALIDHOUS", "DIGESTCARDNO", "ECI", "ED", "ENCCARDNO", "IP", "IPCTY", "NBREMAILUSAGE", "NBRIPUSAGE", "NBRIPUSAGE_ALLTX", "NBRUSAGE", "NCERROR", "ORDERID", "PAYID", "PM", "SCO_CATEGORY", "SCORING", "STATUS", "TRXDATE", "VC"]

    # Separators for the SHA OUT calculation
    params_to_uppercase = params.map { |key, value| [key.to_s.upcase, value] }
    params_sorted = params_to_uppercase.sort

    string_to_hash = ""

    params_sorted.each do |key, value|
      if value != "" && sha_out_params.include?(key)
        string_to_hash = string_to_hash + key + '=' + value + sha_out
      end
    end

    sha1 = Digest::SHA1.hexdigest string_to_hash

    return sha1.upcase == params["SHASIGN"]

  end

  def registration_ok(msg, registration)
    logger.info msg
    flash.now[:notice_title] = "Nous vous remercions de votre inscription."
    flash.now[:notice] = "Un courrier électronique vient de vous être envoyé."
    Js16Mailer.success_email(registration).deliver
  end

  def payment_not_accepted(msg, params)
    logger.error msg
    flash[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
    Js16Mailer.error_email(msg, params).deliver
  end

  def accepted_with_error(msg, params)
    logger.error msg
    flash.now[:notice] = "L'administrateur a été informé et vous serez contacté prochainement."
    Js16Mailer.error_email(msg, getParams).deliver
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "hesav" && password == "be2hax"
    end
  end

end

require 'httparty'
require 'death14_csv_service'

class Death14RegistrationsController < ApplicationController
  
  before_filter :init_values
  before_filter :authenticate, only: [:index]

  def init_values

    #constants
    @event_name = 'death14'
    @shop_id = 'death14dev'
    @environment = 'test' # test/prod
    @language = 'fr_FR'

    # layout
    self.class.layout('death14')
  end

  def admin

    date_start = DateTime.new(2014,8,28,18,00)
    registrations = Death14Registration.where("created_at > :date_start",{date_start: date_start}).order("created_at DESC").all
    @registrations = registrations
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
      format.csv {

        csv_string = DeathCsvService.generate(registrations)

        send_data csv_string.encode("iso-8859-1", :invalid => :replace, :undef => :replace, :replace => "?"),
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=inscriptions.csv" 
      }
    end
  end

  def new

    event = Event.find_by_short_name!(@event_name)

    if event.open < DateTime.now && event.close > DateTime.now
      @registration = Death14Registration.new
    else
      if event.open > DateTime.now
        flash.now[:info] = "L'inscription n'est pas encore disponible"
      else
        flash.now[:info] = "L'inscription n'est plus disponible"
      end
      render "close"
    end
  end

  def create

    event = Event.find_by_short_name!(@event_name)
    
    @registration = Death14Registration.new(post_params)
    @registration.shopID = @shop_id
    @registration.environment = @environment
    @registration.language = @language
    @registration.payed = false
    @registration.event = event

    case @registration.type_short_name
    when "prix_normal"
      @registration.type_price = '60.00'
      @registration.type_name = "Tarif normal"
    when "prix_reduit"
      @registration.type_price = '30.00'
      @registration.type_name = "Tarif réduit"
    when "gratuit"
      @registration.type_price = '00.00'
      @registration.type_name = "Gratuit"
      @registration.payed = true      
    else
      @registration.type_price = '-1'
    end

    if @registration.save && (@registration.type_price != '00.00')
      render 'hiddenform'
    else
      if @registration.save && (@registration.type_price == "00.00")
        msg = "INFO :: Inscription sans frais"
        registration_ok(msg,@registration)
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
      accepted_with_error(msg,getParams)
      render :error
    else
      if getParams["orderID"] != nil
      # La reference de paiement Postfinance. Attention, cette reference est une concatenation du shopID et de l’orderID transmis precedemment (ex. myShopID_myOrderID)
      orderID_back = getParams["orderID"].split('_')[1]
      registration = Death14Registration.find_by_id(orderID_back)
        if registration == nil
          msg = "PostFinance :: Accept Action :: Not Found => (The registration with the id #"+orderID_back+" has not been found)"
          accepted_with_error(msg,getParams)
          render :error
        else
          registration.payed = true
          registration.save
          msg = "PostFinance :: Accept Action :: The registration with the id #"+orderID_back+" has been payed"
          registration_ok(msg,registration)
        end
      else
        msg = "PostFinance :: Accept Action :: orderID return is null"
        accepted(msg,getParams)
        render :error
      end
    end

  end

  def decline

    getParams = request.query_parameters
    msg = 'PostFinance :: Decline Action'
    payment_not_accepted(msg,getParams)
    redirect_to action: "new"

  end

  def cancel

    getParams = request.query_parameters
    msg = 'PostFinance :: Cancel Action'
    payment_not_accepted(msg,getParams)
    redirect_to action: "new"

  end

  def exception

    getParams = request.query_parameters
    msg = 'PostFinance :: Exception Action'
    payment_not_accepted(msg,getParams)
    redirect_to action: "new"

  end

  def cgv
  end

  private

    def post_params
      params.require(:death14_registration).permit(:last_name,:first_name,:type_short_name,:city,:email,:street,:npa,:country,:employer,:job,:workshop)
    end

    def sha_valid(params)

      sha_out = APP_CONFIG["sha_out_test"]
      if @environment == 'prod'
        sha_out = APP_CONFIG["sha_out_prod"]
      end
      
      # List of parameters to be included in SHA OUT calculation (e-commerce Advanced Documentation)
      sha_out_params = ["AAVADDRESS","AAVCHECK","AAVZIP","ACCEPTANCE","ALIAS","AMOUNT","BRAND","CARDNO","CCCTY","CN","COMPLUS","CURRENCY","CVCCHECK","DCC_COMMPERCENTAGE","DCC_CONVAMOUNT","DCC_CONVCCY","DCC_EXCHRATE","DCC_EXCHRATESOURCE","DCC_EXCHRATETS","DCC_INDICATOR","DCC_MARGINPERCENTAGE","DCC_VALIDHOUS","DIGESTCARDNO","ECI","ED","ENCCARDNO","IP","IPCTY","NBREMAILUSAGE","NBRIPUSAGE","NBRIPUSAGE_ALLTX","NBRUSAGE","NCERROR","ORDERID","PAYID","PM","SCO_CATEGORY","SCORING","STATUS","TRXDATE","VC"]

      # Separators for the SHA OUT calculation
      params_to_uppercase = params.map{|key,value| [key.to_s.upcase,value] }
      params_sorted = params_to_uppercase.sort
      
      string_to_hash = ""

      params_sorted.each do |key,value|
        if value != "" && sha_out_params.include?(key)
          string_to_hash = string_to_hash + key + '=' + value + sha_out
        end
      end

      sha1 = Digest::SHA1.hexdigest string_to_hash

      return sha1.upcase == params["SHASIGN"]

    end

    def registration_ok(msg,registration)
      logger.info msg
      flash.now[:notice_title] = "Merci, votre inscription a bien été enregistrée"
      flash.now[:notice] = "Un message automatique de confirmation vient d'être envoyé à votre adresse mail."
      Death14Mailer.success_email(registration).deliver
    end

    def payment_not_accepted(msg,params)
      logger.error msg
      flash[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
      Death14Mailer.error_email(msg,params).deliver
    end

    def accepted_with_error(msg,params)
      logger.error msg
      flash.now[:notice] = "L'administrateur a été informé et vous serez contacté prochainement."
      Death14Mailer.error_email(msg,params).deliver
    end
  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
      username == "hesav" && password == "be2hax"
    end
  end

end

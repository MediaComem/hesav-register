require 'httparty'
require 'gouveole_csv_service'

class GouveoleRegistrationsController < ApplicationController
  
  before_filter :init_values
  before_filter :authenticate, only: [:admin]

  def init_values

    #constants
    @event_name = 'gouveole'
    @shop_id = 'test'
    @environment = 'test'
    @language = 'fr_FR'
    @price = '500.00'

    @number_limit = 1#17
    @number_max = 4#25

    # layout
    self.class.layout('gouveole')
  end

  def admin
    event = Event.find_by_short_name!(@event_name)

    @registrations = GouveoleRegistration.where("event_id = :event_id",{event_id: event.id}).order("created_at DESC").all
    @paid_registrations = GouveoleRegistration.where("event_id = :event_id and paid = :paid",{event_id: event.id, paid: true}).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
      format.csv {

        csv_string = CsvService.generate(@registrations)

        send_data csv_string.encode("iso-8859-1", :invalid => :replace, :undef => :replace, :replace => "?"),
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=inscriptions.csv" 
      }
    end
  end

  def new
    event = Event.find_by_short_name!(@event_name)

    @registrations_count = registration_number

    now = DateTime.now
    if event.open >= now
      flash.now[:info] = "L'inscription n'est pas encore disponible"
      render "close"
    elsif now >= event.close
      flash.now[:info] = "L'inscription n'est plus disponible"
      render "close"
    elsif @registrations_count >= @number_max
      flash.now[:info] = "Les nombre maximum d'inscriptions pour ce cours a été atteint"
      render "close"
    else
      @registration = GouveoleRegistration.new
    end
  end

  def create
    event = Event.find_by_short_name!(@event_name)

    @registrations_count = registration_number

    @registration = GouveoleRegistration.new(post_params)
    @registration.event = event
    @registration.price = @price
    @registration.paid = false #not paid by default

    if @registration.save
      render 'hiddenform'
    else
      @title = (params[:gouveole_registration][:title])
      @affiliation = (params[:gouveole_registration][:affiliation])
      render 'new'
    end
  end

  def accepted
    getParams = request.query_parameters

    if !sha_valid(getParams)
      msg = "PostFinance :: Accept Action :: The SHA-OUT is not valid"
      accepted_with_error(msg, getParams)
      render :error
    else
      logger.info "SHA IS VALID"
      if getParams["orderID"] != nil
        # La reference de paiement Postfinance. Attention, cette reference est une concatenation du shopID et de l’orderID transmis precedemment (ex. myShopID_myOrderID)
        tab = getParams["orderID"].split('_')
        store_name = tab[0]
        order_id = tab[1]

        registration = GouveoleRegistration.find_by_id(order_id)
        if registration == nil
          msg = "PostFinance :: Accept Action :: The registration with the id #"+order_id+" has not been found"
          accepted_with_error(msg,getParams)
          render :error
        else
          registration.paid = true
          registration.save
          msg = "PostFinance :: Accept Action :: The registration with the id #"+order_id+" has been payed"
          registration_ok(msg, registration)
          render "accepted"
        end
      else
        msg = "PostFinance :: Accept Action :: order_id is null"
        accepted_with_error(msg, getParams)
        render :error
      end
    end
  end

  def decline
    getParams = request.query_parameters
    if getParams["orderID"] != nil
      tab = getParams["orderID"].split('_')
      registration = GouveoleRegistration.find_by_id(tab[1])
    end
    msg = 'PostFinance/Decline'
    payment_not_accepted(msg, getParams, registration)
    redirect_to action: "new"
  end
  
  # TODO multi-boutiques
  def cancel
    getParams = request.query_parameters
    if getParams["orderID"] != nil
      tab = getParams["orderID"].split('_')
      registration = GouveoleRegistration.find_by_id(tab[1])
    end
    msg = 'PostFinance/Cancel'
    payment_not_accepted(msg, getParams, registration)
    redirect_to action: "new"
  end
  
  # TODO multi-boutiques
  def exception
    getParams = request.query_parameters
    if getParams["orderID"] != nil
      tab = getParams["orderID"].split('_')
      registration = GouveoleRegistration.find_by_id(tab[1])
    end
    msg = 'PostFinance/Exception'
    payment_not_accepted(msg, getParams, registration)
    redirect_to action: "new"
  end

  def cgv
  end

private
  def post_params
    params.require(:gouveole_registration).permit(
     :title,
     :last_name,
     :first_name,
     :email,
     :phone,
     :affiliation, 
     :affiliation_address,
     :job,
     :theorical_knowledge,
     :practical_p_knowledge,
     :practical_o_knowledge,
     :no_knowledge,
     :expectations,
     :activities,
     :remarks,
     :rules_accepted)
  end

  def sha_valid(params)
    # List of parameters to be included in SHA OUT calculation (e-commerce Advanced Documentation)
    sha_out_params = ["AAVADDRESS","AAVCHECK","AAVZIP","ACCEPTANCE","ALIAS","AMOUNT","BRAND","CARDNO","CCCTY","CN","COMPLUS","CURRENCY","CVCCHECK","DCC_COMMPERCENTAGE","DCC_CONVAMOUNT","DCC_CONVCCY","DCC_EXCHRATE","DCC_EXCHRATESOURCE","DCC_EXCHRATETS","DCC_INDICATOR","DCC_MARGINPERCENTAGE","DCC_VALIDHOUS","DIGESTCARDNO","ECI","ED","ENCCARDNO","IP","IPCTY","NBREMAILUSAGE","NBRIPUSAGE","NBRIPUSAGE_ALLTX","NBRUSAGE","NCERROR","ORDERID","PAYID","PM","SCO_CATEGORY","SCORING","STATUS","TRXDATE","VC"]
    # Separators for the SHA OUT calculation
    params_to_uppercase = params.map{|key,value| [key.to_s.upcase,value] }
    params_sorted = params_to_uppercase.sort
    string_to_hash = ""
    params_sorted.each do |key,value|
      if value != "" && sha_out_params.include?(key)
        string_to_hash = string_to_hash + key + '=' + value + APP_CONFIG["sha_out"] 
      end
    end
    sha1 = Digest::SHA1.hexdigest string_to_hash
    return sha1.upcase == params["SHASIGN"]
  end

  # after a cancel/decline/exception action
  def payment_not_accepted(msg,params,registration)
    logger.error msg
    flash[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
    GouveoleMailer.registration_not_completed(msg,params,registration).deliver
  end

  # after an accept action
  def registration_ok(msg,registration)
    if registration_number > @number_limit
      flash.now[:notice_title] = "Merci, votre demande d'inscription a bien été enregistrée"
      flash.now[:notice] = "Un message automatique vient d'être envoyé à votre adresse mail."
      GouveoleMailer.success_not_confirmed_email(registration).deliver
    else
      flash.now[:notice_title] = "Merci, votre inscription a bien été enregistrée"
      flash.now[:notice] = "Un message automatique de confirmation vient d'être envoyé à votre adresse mail."
      GouveoleMailer.success_confirmed_email(registration).deliver
    end
  end

  # after an accept action with SHA calculation problem
  def accepted_with_error(msg,params)
    logger.error msg
    flash.now[:notice] = "L'administrateur a été informé et vous serez contacté prochainement."
    GouveoleMailer.error_email(msg, params).deliver
  end

  # return the number of paid registrations
  def registration_number
    event = Event.find_by_short_name!(@event_name)
    paid_registrations = GouveoleRegistration.where("event_id = :event_id and paid = :paid",{event_id: event.id, paid: true}).all
    return paid_registrations.count
  end

  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
      username == "gouveole" && password == "Vod9we4t"
    end
  end

end

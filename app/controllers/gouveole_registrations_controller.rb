class GouveoleRegistrationsController < ApplicationController
  
  before_filter :init_values
  def init_values
    @event_name = 'gouveole'
    @shop_id = 'test'
    @environment = 'test'
    @language = 'fr_FR'
    @price = '500.00'
  end

  def new
    event = Event.find_by_short_name!(@event_name)
    now = DateTime.now

    if event.open >= now
      flash.now[:info] = "L'inscription n'est pas encore disponible"
      render "close"
    elsif now >= event.close
      flash.now[:info] = "L'inscription n'est plus disponible"
      render "close"
    else
      @registration = GouveoleRegistration.new
    end
  end

  def create
    event = Event.find_by_short_name!(@event_name)

    @registration = GouveoleRegistration.new(post_params)
    @registration.event = event
    @registration.price = @price
    @registration.paid = false #not paid by default

    if @registration.save
      render 'hiddenform'
    else
      #flash.now[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
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
      #    msg = "PostFinance :: Accept Action :: The registration with the id #"+orderID_back+" has been payed"
      #    registration_ok(msg,registration)
      #    render File.join(params[:controller], keyName, params[:action])
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
    msg = 'PostFinance :: Decline Action'
    payment_not_accepted(msg, getParams)
    redirect_to action: "new"
  end
  
  # TODO multi-boutiques
  def cancel
    getParams = request.query_parameters
    msg = 'PostFinance :: Cancel Action'
    payment_not_accepted(msg, getParams)
    redirect_to action: "new"
  end
  
  # TODO multi-boutiques
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
    params.require(:gouveole_registration).permit(:male,
     :last_name,
     :first_name,
     :email,
     :phone,
     :affiliation, 
     :affiliation_address,
     :job,
     :billing_address,
     :theorical_knowledge,
     :practical_p_knowledge,
     :practical_o_knowledge,
     :no_knowledge,
     :expectations,
     :activities,
     :remarks)
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

  def accepted_with_error(msg,params)
    logger.error msg
    flash.now[:notice] = "L'administrateur a été informé et vous serez contacté prochainement."
    NotificationMailer.error_email(msg, params).deliver
  end

  def payment_not_accepted(msg,params)
    logger.error msg
    flash[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
    NotificationMailer.error_email(msg,params).deliver
  end

end

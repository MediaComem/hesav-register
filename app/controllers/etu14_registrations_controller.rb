class Etu14RegistrationsController < ApplicationController
  
  before_filter :init_values

  def init_values

    # constants
    @event_name = 'etu14'
    @language = 'fr_FR'
    
    # shop
    @shop_id = 'etu14dev'
    @environment = 'test'

    @price = 50;

    # layout
    self.class.layout('etu14')
  end

  def new
    event = Event.find_by_short_name!(@event_name)
    if event.open < DateTime.now && event.close > DateTime.now
      @registration = Etu14Registration.new
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
    
    @registration = Etu14Registration.new(post_params)
    @registration.payed = false
    @registration.event = event

    @registration.price = 100

    if @registration.save && (@price != '00.00')
      render 'hiddenform'
    else
      if @registration.save && (@price == "00.00")
        msg = "INFO :: Inscription sans frais"
        #registration_ok(msg,@registration)
        render 'accepted'
      else
        @title = params[:etu14_registration][:title]
        @institution = params[:etu14_registration][:employer]
        @job = params[:etu14_registration][:job]

        logger.info "--------------------------"
        logger.info @title
        logger.info @institution
        logger.info @job

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

        registration = Etu14Registration.find_by_id(orderID_back)
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

    def payment_not_accepted(msg,params)
      logger.error msg
      flash[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
      Etu14Mailer.error_email(msg,params).deliver
    end

    def registration_ok(msg,registration)
      logger.info msg
      flash.now[:notice_title] = "Merci, votre inscription a bien été enregistrée"
      flash.now[:notice] = "Un message automatique de confirmation vient d'être envoyé à votre adresse mail."
      Etu14Mailer.success_email(registration).deliver
    end

    def payment_not_accepted(msg,params)
      logger.error msg
      flash[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
      Etu14Mailer.error_email(msg,params).deliver
    end

    def accepted_with_error(msg,params)
      logger.error msg
      flash.now[:notice] = "L'administrateur a été informé et vous serez contacté prochainement."
      Etu14Mailer.error_email(msg,getParams).deliver
    end

    def post_params
      params.require(:etu14_registration).permit(:title,:last_name,:first_name,:street,:npa,:city,:country,:employer,:job,:email,:registration_type,:assistance,:payed,:event_id)
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

end

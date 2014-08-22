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
    @registration.shopID = @shop_id
    @registration.environment = @environment
    @registration.language = @language
    @registration.payed = false
    @registration.event = event

    if @registration.save && (@price != '00.00')
      render 'hiddenform'
    else
      if @registration.save && (@price == "00.00")
        msg = "INFO :: Inscription sans frais"
        #registration_ok(msg,@registration)
        render 'accepted'
      else
        flash.now[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
        render "new"
      end
    end
  end

  private
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

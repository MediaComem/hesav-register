class GouveoleRegistrationsController < ApplicationController
  
  before_filter :init_values
  def init_values
    @event_name = 'gouveole'
    @shop_id = 'gouveole'
    @environment = 'test'
    @language = 'fr_FR'
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
    @registration.paid = false
    @registration.event = event
    @registration.price = '500.00'

    logger.error post_params

    if @registration.save
      render 'hiddenform'
    else
      flash.now[:notice_error] = "Une erreur est survenue. Veuillez recommencer le processus d'inscription."
      render 'new'
    end
  end

private
  def post_params
    params.require(:gouveole_registration).permit(:male, :last_name,:first_name, :email)
  end

end

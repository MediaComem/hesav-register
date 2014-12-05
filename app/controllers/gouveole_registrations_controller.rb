require 'gouveole_csv_service'

class GouveoleRegistrationsController < ApplicationController
  
  before_filter :init_values
  before_filter :authenticate, only: [:admin]
  before_action :load_wizard, only: [:new, :create]

  def init_values
    #constants
    @event_name = 'gouveole'
    @price = '500.00'

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

    now = DateTime.now
    if event.open >= now
      flash.now[:info] = "L'inscription n'est pas encore disponible"
      render "close"
    elsif now >= event.close
      flash.now[:info] = "Les inscriptions à la formation sont maintenant closes. Pour toute demande, vous pouvez nous contacter à gouveole@heig-vd.ch"
      render "close"
    else
      @registration = @wizard.object
    end
  end

  def create

    event = Event.find_by_short_name!(@event_name)

    @registration = @wizard.object
    @registration.event = event
    @registration.price = @price
    
    if @wizard.save
      GouveoleMailer.success_not_confirmed_email(@registration).deliver
      render "_step4"
    else
      @title = (params[:gouveole_registration][:title])
      @affiliation = (params[:gouveole_registration][:affiliation])
      render :new
    end

  end

  def cgv
  end

private

  def load_wizard
    @wizard = ModelWizard.new(@registration || GouveoleRegistration, session, params)
    if self.action_name.in? %w[new edit]
      @wizard.start
    elsif self.action_name.in? %w[create update]
      @wizard.process
    end
  end

  # # after an accept action
  # def registration_ok(msg,registration)
  #   if registration_number > @number_limit
  #     flash.now[:notice_title] = "Merci, votre demande d'inscription a bien été enregistrée"
  #     flash.now[:notice] = "Un message automatique vient d'être envoyé à votre adresse mail."
  #     GouveoleMailer.success_not_confirmed_email(registration).deliver
  #   else
  #     flash.now[:notice_title] = "Merci, votre inscription a bien été enregistrée"
  #     flash.now[:notice] = "Un message automatique de confirmation vient d'être envoyé à votre adresse mail."
  #     GouveoleMailer.success_confirmed_email(registration).deliver
  #   end
  # end

  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
      username == "gouveole" && password == "Vod9we4t"
    end
  end

end

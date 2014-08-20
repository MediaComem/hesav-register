class Etu14RegistrationsController < ApplicationController
  
  before_filter :init_values

  def init_values

    # constants
    @event_name = 'etu14'
    @language = 'fr_FR'
    
    # shop
    @shop_id = 'etu14dev'
    @environment = 'test'

    # layout
    self.class.layout('psy14')
  end

end

class Psy17Registration < ActiveRecord::Base
  before_save :default_values
  validates :last_name,:first_name,:employer,:job,:email,:shopID,:npa,:city,:street,:streetnumber,  presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  store_accessor :registration_type, [
    :type_price,
    :type_choice_am,
    :type_choice_pm
  ]
  belongs_to :event
  def default_values
    self.payed ||= false
    true
  end
  def self.ateliers
    [
      {:name=>"ATELIER 1",:slug=>"atelier1",:descr=>"Espace musical dans la chambre de soins intensifs (DP-CHUV & HESAV)"},
      {:name=>"ATELIER 2",:slug=>"atelier2",:descr=>"Comment je parle de ma maladie à mes enfants ? Pôle de Psychiatrie et Psychothérapie, Hôpital du Valais / CHVR"},
      {:name=>"ATELIER 3",:slug=>"atelier3",:descr=>"Traitement à domicile (Mendrisio, Tessin)"},
      {:name=>"ATELIER 4",:slug=>"atelier4",:descr=>"Polyphonie de la crise psychique : pratiques et regards entre police et psychiatrie (RFSM)"},
      {:name=>"ATELIER 5",:slug=>"atelier5",:descr=>"Tandem compétentiel infirmier au coeur d’un nouveau modèle d’intervention au SMUR (CPN)"},
      {:name=>"ATELIER 6",:slug=>"atelier6",:descr=>"Le Parterre, bilan, enjeux et perspectives d’une prestation socio-thérapeutique (RSM)"},
      {:name=>"ATELIER 7",:slug=>"atelier7",:descr=>"Groupe de soutien à la parentalité pour les personnes dépendantes (DP-CHUV)"}]
  end
end
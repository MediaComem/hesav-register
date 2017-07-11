class Js17Registration < ActiveRecord::Base
	before_save :default_values
  validates :last_name,:first_name,:employer,:job,:email,:shopID,:npa,:city,:street,:streetnumber,:type_choice,  presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
	store_accessor :registration_type, [
    :type_price,
    :type_choice
  ]
  belongs_to :event
  def default_values
    self.payed ||= false
    true
  end
  def self.ateliers
    [{"name":"ATELIER 1","slug":"atelier1","descr":"Système de synchronisation de signaux physiologiques et biomécaniques en cyclisme : contrôle des paramètres de santé"},{"name":"ATELIER 2","slug":"atelier2","descr":"Entraînement sur vélo : de l’endurance continue aux sprints répétés","more":"(Tenue de sport nécessaire, atelier limité à 16 personnes)"},{"name":"ATELIER 3","slug":"atelier3","descr":"Dynamique de l'échographie du membre supérieur","more":"(Atelier pratique, limité à 15 personnes)"},{"name":"ATELIER 4","slug":"atelier4","descr":"Activité physique et cancer chez l’enfant : PASTEC pour avoir la pêche !"},{"name":"ATELIER 5","slug":"atelier5","descr":"Promotion du mouvement chez la femme enceinte, programme cantonal « ça marche »"},{"name":"ATELIER 6","slug":"atelier6","descr":"Je marche plus d'une heure par jour, et je m'en porte très bien, merci!"}]
  end
end
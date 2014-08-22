class Etu14Registration < ActiveRecord::Base
  belongs_to :event
  before_save :default_values

  validates :title,:last_name,:first_name,:street,:npa,:city,:country,:employer,:job,:email,:price, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :assistance, inclusion: [true, false]
  #validates :assistance, inclusion: { in: %w(true false), message: "BLABLA" }
  validate :validate_registration_type

  def default_values
      self.payed ||= false
    true
  end

  def validate_registration_type
    if (registration_type.blank?)
      errors.add(:base, "Veuillez sélectionner par les journées à choix")
    end
  end

  def friendly_employer
    case employer
    when "nant"
      "Fondation de Nant"
    when "valais"
      "DPP-CHVR Hôpital du Valais"
    when "hesav"
      "HESAV"
    when "autre"
      "Autre"
    end
  end

  def friendly_job
    case job
    when "infirmier"
     "Infirmier"
    when "medecin"
     "Médecin"
    when "psychologue"
     "Psychologue"
    when "psychomotricien"
     "Psychomotricien"
    when "educateur"
     "Educateur"
    when "etudiant"
     "Etudiant"
    when "autre"
     "Autre"
    end
  end

end

class GouveoleRegistration < ActiveRecord::Base
  before_save :default_values

  #validatations
  #validates :male, :last_name, :first_name, :affiliation, :affiliation_address, :job, :billing_address, :expectations, :activities, presence: true
  #validate :knowledge
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  
  #relations
  belongs_to :event



private
  def default_values
      self.paid ||= false
    true
  end
  def knowledge
    if !(theorical_knowledge.blank? ^ practical_p_knowledge.blank? ^ practical_o_knowledge.blank? ^ no_knowledge.blank?)
      errors.add(:base, "Sélectionner au moins une connaissance des démarches participatives")
    end
  end
end
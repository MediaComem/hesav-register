class GouveoleRegistration < ActiveRecord::Base
  before_save :default_values

  #validatations
  validates :male, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :phone, presence: true
  validates :affiliation, presence: true
  validates :affiliation_address, presence: true
  validates :job, presence: true
  validates :billing_address, presence: true
  validates :expectations, presence: true
  validates :activities, presence: true

  validate :knowledge
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

    logger.info "----------------------"
    logger.info theorical_knowledge
    logger.info practical_p_knowledge
    logger.info practical_o_knowledge
    logger.info no_knowledge
    logger.info "----------------------"

    # at least one checkbox should be checked
    if (theorical_knowledge.blank? and practical_p_knowledge.blank? and practical_o_knowledge.blank? and no_knowledge.blank?)
      errors.add(:base, "Sélectionner au moins une connaissance des démarches participatives")
    end
  end
end
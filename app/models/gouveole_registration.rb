class GouveoleRegistration < ActiveRecord::Base
  before_save :default_values

  #validatations
  validates :title, presence: true, if: :step3?
  validates :last_name, presence: true, if: :step3?
  validates :first_name, presence: true, if: :step3?
  validates :phone, presence: true, if: :step3?
  validates :affiliation, presence: true, if: :step3?
  validates :affiliation_address, presence: true, if: :step3?
  validates :job, presence: true, if: :step3?
  validates :expectations, presence: true, if: :step3?
  validates :activities, presence: true, if: :step3?
  validates :event, presence: true, if: :step3?

  validate :rules, if: :step2?
  validate :knowledge, if: :step3?

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, if: :step3?
  
  #relations
  belongs_to :event

  include MultiStepModel

  def self.total_steps
    3
  end

  def current_percentage
    # 25 - 50 - 75 - 100
    (self.current_step+1)*25
  end

private
  def default_values
      self.paid ||= false
    true
  end
  def knowledge
    # at least one checkbox should be checked
    if (theorical_knowledge.blank? and practical_p_knowledge.blank? and practical_o_knowledge.blank? and no_knowledge.blank?)
      errors.add(:base, "Sélectionner au moins une connaissance des démarches participatives")
    end
  end
  def rules
    # registrants must accept the formation rules
    if (rules_accepted.blank?)
      errors.add(:base, "Vous devez vous engager à respecter les dispositions")
    end
  end
end

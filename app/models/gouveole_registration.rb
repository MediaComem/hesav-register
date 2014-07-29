class GouveoleRegistration < ActiveRecord::Base
  before_save :default_values
  #validatations
  validates :last_name, :first_name, presence: true
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, format: { with: VALID_EMAIL_REGEX }
  #relations
  belongs_to :event

  def default_values
      self.paid ||= false
    true
  end

end
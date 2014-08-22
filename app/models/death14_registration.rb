class Death14Registration < ActiveRecord::Base
before_save :default_values
validates :last_name,:first_name,:employer,:job,:email,:shopID,  presence: true
validates :type_price, inclusion: { in: %w(80.00 40.00 00.00)}
validates :workshop, inclusion: { in: %w(inegalite-de-traitement deuil-perinatal lorsque-la-mort faire-parler-les-morts)}
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, format: { with: VALID_EMAIL_REGEX }
store_accessor :registration_type, [
    :type_price,
    :type_name,
    :type_short_name
  ]
def default_values
    self.payed ||= false
  true
end
belongs_to :event
end

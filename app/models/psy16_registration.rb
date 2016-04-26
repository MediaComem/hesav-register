class Psy16Registration < ActiveRecord::Base
	before_save :default_values
	validates :last_name,:first_name,:employer,:job,:email,:shopID,:country,:npa,:city,:street,  presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL_REGEX }
	store_accessor :registration_type, [
    :type_morning,
    :type_afternoon,
    :type_lunch,
    :type_price
  ]
  belongs_to :event
end
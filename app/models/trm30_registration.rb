class Trm30Registration < ActiveRecord::Base
	validates :last_name,:first_name,:employer,:email,:npa,:city,:street,:streetnumber,  presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL_REGEX }
  belongs_to :event
end
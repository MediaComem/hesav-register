class Js16Registration < ActiveRecord::Base
	before_save :default_values
	validates :last_name, :first_name, :employer, :email, :shopID, :npa, :city, :street, :type_choice, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: {with: VALID_EMAIL_REGEX}
	store_accessor :registration_type, [
		:type_price,
		:type_choice
	]
	belongs_to :event

	def default_values
		self.payed ||= false
		true
	end
end
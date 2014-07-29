class Registration < ActiveRecord::Base
  #validatations
  validates :last_name, :first_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  #relations
  belongs_to :event
  has_many :fields
end

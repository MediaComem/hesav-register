class Psy16Registration < ActiveRecord::Base
	store_accessor :registration_type, [
    :type_morning,
    :type_afternoon,
    :type_lunch,
    :type_price
  ]
  belongs_to :event
end
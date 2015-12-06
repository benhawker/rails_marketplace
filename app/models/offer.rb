class Offer < ActiveRecord::Base
	#Associations
	has_one :listing
	has_one :user

  #Association validations
  validates_presence_of :listing
  validates_presence_of :user

  #Attribute validations
  validates_presence_of :price, message: "Your offer must have a price!"
end

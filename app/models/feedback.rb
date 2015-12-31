class Feedback < ActiveRecord::Base

	#Associations
	belongs_to :listing
	belongs_to :seller, :foreign_key => :seller_id, class_name: "User"
	belongs_to :buyer, :foreign_key => :buyer_id, class_name: "User"

  #Association validations
  validates_presence_of :seller
  validates_presence_of :buyer
  validates_presence_of :listing

  #Attribute validations
  validates_uniqueness_of :seller_id, :scope => :listing_id

end

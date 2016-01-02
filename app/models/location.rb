class Location < ActiveRecord::Base
	has_many :users
	has_many :listings

  def geocoded?
		self.latitude.present? && self.longitude.present?
	end 	

end

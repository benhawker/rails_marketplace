class Location < ActiveRecord::Base
	has_many :users
	has_many :listings

	geocoded_by :full_address
	after_validation :geocode
	before_save :geocode, :if => :full_address_changed?

  def geocoded?
		self.latitude.present? && self.longitude.present?
	end

end

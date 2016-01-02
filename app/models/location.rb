class Location < ActiveRecord::Base
	has_many :users
	has_many :listings


	 def geocoded?
    self.lat.present? && self.lng.present?
  end
end

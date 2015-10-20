class Listing < ActiveRecord::Base
	belongs_to :user

	def self.search(search)
	  where("title ILIKE ?", "%#{search}%") 
	end
end

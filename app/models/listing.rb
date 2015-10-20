class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :watches
	has_many :watchers, :through => :watches

	def self.search(search)
	  where("title ILIKE ?", "%#{search}%") 
	end
end

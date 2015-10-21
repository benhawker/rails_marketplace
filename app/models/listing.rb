class Listing < ActiveRecord::Base
	belongs_to :user
	belongs_to :category, inverse_of: :listings
	has_many :photos, dependent: :destroy 
	has_many :watches
	has_many :watchers, -> { uniq }, :through => :watches

	accepts_nested_attributes_for :category, :photos

	# validates_presence_of :category

	def self.search(search)
	  where("title ILIKE ?", "%#{search}%") 
	end


end

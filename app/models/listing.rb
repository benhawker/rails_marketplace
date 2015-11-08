class Listing < ActiveRecord::Base

	#Associations
	belongs_to :user
	belongs_to :category, inverse_of: :listings
	has_many :photos, dependent: :destroy 
	has_many :watches
	has_many :watchers, -> { uniq }, :through => :watches
 
 	# Nested Attributes
	accepts_nested_attributes_for :category, :photos

	# Tags
	acts_as_taggable_on :tags

	# Association validations
	validates_presence_of :category
	validates_presence_of :user
	# validates_presence_of :photo, message: "Please add a photo. Every listing minimum 1 photo."

	# Attribute validations
	validates_presence_of :title, message: "Please add a title."
	validates_presence_of :subtitle, message: "Please add a subtitle."
	validates_presence_of :price, message: "Please add a price."
	validates_presence_of :title, message: "Please select a condition."
	validates_presence_of :location, message: "Please select a location."

	def self.search(search)
	  where("title ILIKE ?", "%#{search}%") 
	end


end

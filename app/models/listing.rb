class Listing < ActiveRecord::Base

	#Associations
	belongs_to :user
	belongs_to :category, inverse_of: :listings
	has_many :photos, dependent: :destroy 
	has_many :watches
	has_many :watchers, -> { uniq }, :through => :watches
 
	accepts_nested_attributes_for :category, :photos

	acts_as_taggable_on :tags

	#Association validations
	validates_presence_of :category
	validates_presence_of :user

	#Attribute validations
	validates_presence_of :title, message: "Please add a title."

	def self.search(search)
	  where("title ILIKE ?", "%#{search}%") 
	end


end

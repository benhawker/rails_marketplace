class Category < ActiveRecord::Base 
  has_many :listings, inverse_of: :category

  accepts_nested_attributes_for :listings
end

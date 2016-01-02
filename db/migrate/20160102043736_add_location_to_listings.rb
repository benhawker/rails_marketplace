class AddLocationToListings < ActiveRecord::Migration
  def change
  	add_reference :listings, :location, index: true, foreign_key: true
  end
end

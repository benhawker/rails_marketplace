class AddCategoryIdToListings < ActiveRecord::Migration
  def change
  	add_reference :listings, :category, index: true, foreign_key: true
  end
end

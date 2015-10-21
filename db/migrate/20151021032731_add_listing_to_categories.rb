class AddListingToCategories < ActiveRecord::Migration
  def change
  	add_reference :categories, :listing, index: true, foreign_key: true
  end
end

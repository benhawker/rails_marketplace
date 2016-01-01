class AddFeaturedToListings < ActiveRecord::Migration
  def change
  	add_column :listings, :featured, :boolean, default: false
  end
end

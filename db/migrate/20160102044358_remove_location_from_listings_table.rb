class RemoveLocationFromListingsTable < ActiveRecord::Migration
  def change
  	remove_column :listings, :location
  end
end

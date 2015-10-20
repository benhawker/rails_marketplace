class AddListingToWatches < ActiveRecord::Migration
  def change
  	add_reference :watches, :listing, index: true, foreign_key: true
  end
end

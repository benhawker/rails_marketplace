class AddListingToPhotos < ActiveRecord::Migration
  def change
  	add_reference :photos, :listing, index: true, foreign_key: true
  end
end

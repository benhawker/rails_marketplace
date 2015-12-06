class AddListingToOffers < ActiveRecord::Migration
  def change
  	add_reference :offers, :listing, index: true, foreign_key: true
  end
end

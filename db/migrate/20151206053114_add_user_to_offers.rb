class AddUserToOffers < ActiveRecord::Migration
  def change
  	add_reference :offers, :user, index: true, foreign_key: true
  end
end

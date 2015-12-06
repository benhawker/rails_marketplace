class AddAttributesToOffers < ActiveRecord::Migration
  def change
  	add_column :offers, :price, :string
  end
end

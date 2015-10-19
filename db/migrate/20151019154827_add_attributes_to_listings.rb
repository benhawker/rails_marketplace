class AddAttributesToListings < ActiveRecord::Migration
  def change
  	add_column :listings, :title, :string
  	add_column :listings, :subtitle, :string
  	add_column :listings, :description, :string
  	add_column :listings, :price, :float
  	add_column :listings, :condition, :string
  	add_column :listings, :brand, :string
  	add_column :listings, :model, :string
  	add_column :listings, :case_type, :string
  	add_column :listings, :location, :string
  end
end

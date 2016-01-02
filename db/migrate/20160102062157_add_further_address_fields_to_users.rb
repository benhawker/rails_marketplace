class AddFurtherAddressFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :house_number, :string
  	add_column :users, :location, :string
  	add_column :users, :street_address, :string
  	add_column :users, :postal_code, :string
  end
end
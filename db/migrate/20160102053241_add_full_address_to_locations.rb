class AddFullAddressToLocations < ActiveRecord::Migration
  def change
  	add_column :locations, :full_address, :string, limit: 255
  end
end

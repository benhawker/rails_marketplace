class AddAttributesToProfiles < ActiveRecord::Migration
  def change
  	add_column :profiles, :city, :string
  	add_column :profiles, :country, :string
  end
end

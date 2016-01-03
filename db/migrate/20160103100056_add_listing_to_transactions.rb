class AddListingToTransactions < ActiveRecord::Migration
  def change
  	add_reference :transactions, :listing, index: true, foreign_key: true
  end
end

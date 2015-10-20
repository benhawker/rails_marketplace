class AddUserToWatches < ActiveRecord::Migration
  def change
  	add_reference :watches, :user, index: true, foreign_key: true
  end
end

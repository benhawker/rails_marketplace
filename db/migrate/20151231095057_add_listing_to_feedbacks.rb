class AddListingToFeedbacks < ActiveRecord::Migration
  def change
  	add_reference :feedbacks, :listing, index: true, foreign_key: true
  end
end

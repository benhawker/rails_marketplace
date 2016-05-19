class AddSellerAndBuyerIdToFeedbacks < ActiveRecord::Migration
  def change
    change_table :feedbacks do |t|
   		t.integer :seller_id
   		t.integer :buyer_id
    end
  end
end

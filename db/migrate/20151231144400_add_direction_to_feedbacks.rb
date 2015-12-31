class AddDirectionToFeedbacks < ActiveRecord::Migration
  def change
  	add_column :feedbacks, :direction, :string, default: "buyer_to_seller"
  end
end

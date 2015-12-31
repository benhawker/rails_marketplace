class AddTypeToFeedbacks < ActiveRecord::Migration
  def change
  	add_column :feedbacks, :type, :string, default: "buyer_to_seller"
  end
end

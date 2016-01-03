class AddTransactionToFeedbacks < ActiveRecord::Migration
  def change
  	add_reference :feedbacks, :transaction, index: true, foreign_key: true
  end
end

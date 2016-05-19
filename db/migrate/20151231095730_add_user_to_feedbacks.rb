class AddUserToFeedbacks < ActiveRecord::Migration
  def change
  	add_reference :feedbacks, :user, index: true, foreign_key: true
  end
end

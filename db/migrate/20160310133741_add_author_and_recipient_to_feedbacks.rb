class AddAuthorAndRecipientToFeedbacks < ActiveRecord::Migration
  def change
  	change_table :feedbacks do |t|
  		t.integer :author_id
  		t.integer :recipient_id
  	end
  end
end
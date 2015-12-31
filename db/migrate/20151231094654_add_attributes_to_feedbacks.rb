class AddAttributesToFeedbacks < ActiveRecord::Migration
  def change
  	add_column :feedbacks, :rating, :boolean
  	add_column :feedbacks, :comment, :string
  end
end
class AddUserIdAndFollowerIdToFollowerRelationships < ActiveRecord::Migration
	def change
		change_table :follower_relationships do |t|
  		t.integer :user_id, null: false
    	t.integer :follower_id, null: false
   	end

    add_index :follower_relationships, [ :user_id, :follower_id ], unique: true
    add_index :follower_relationships, :user_id
    add_index :follower_relationships, :follower_id
	end
end
class CreateFollowerRelationships < ActiveRecord::Migration
  def change
    create_table :follower_relationships do |t|

      t.timestamps null: false
    end
  end
end

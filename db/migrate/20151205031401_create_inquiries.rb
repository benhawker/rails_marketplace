class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
   		t.integer :sender_id
   		t.integer :recipient_id
      t.integer :listing_id
      t.timestamps
    end
  end
end

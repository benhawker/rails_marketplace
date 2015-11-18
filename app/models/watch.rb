class Watch < ActiveRecord::Base
  belongs_to :watcher, :class_name => 'User', :foreign_key => "user_id"
  belongs_to :watched_listing, :class_name => 'Listing', :foreign_key => "listing_id"
end

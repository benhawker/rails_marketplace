class FollowerRelationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :follower, :class_name => "User"
  
  validates :user_id, :presence => true
  validates :follower_id, :presence => true, :uniqueness => { :scope => :user_id }, :exclusion => { :in => lambda { |x| [ x.user_id ] } }
end
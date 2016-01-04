require 'rails_helper'

RSpec.describe FollowerRelationship, type: :model do
	it { should belong_to(:user) }
  it { should belong_to(:follower).class_name("User") }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:follower_id) }
end

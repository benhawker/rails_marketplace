require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { should belong_to(:seller).class_name('User').with_foreign_key('seller_id') }
  it { should belong_to(:buyer).class_name('User').with_foreign_key('buyer_id') }

  it { should belong_to(:listing) }

  it { should validate_presence_of(:seller) }
  it { should validate_presence_of(:buyer) }
  it { should validate_presence_of(:listing) }

	it { should validate_uniqueness_of(:seller_id).scoped_to(:listing_id) }
end

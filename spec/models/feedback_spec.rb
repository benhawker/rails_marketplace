require 'rails_helper'

RSpec.describe Feedback, type: :model do

  it { should belong_to(:seller).class_name('User').with_foreign_key('seller_id') }
  it { should belong_to(:buyer).class_name('User').with_foreign_key('buyer_id') }

  it { should belong_to(:listing) }
end

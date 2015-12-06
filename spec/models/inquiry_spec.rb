require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  it { should belong_to(:sender).class_name('User').with_foreign_key('sender_id') }
  it { should belong_to(:recipient).class_name('User').with_foreign_key('recipient_id') }
  it { should belong_to(:listing) }
  it { should have_many(:messages) }

  it { should validate_presence_of(:sender) }
  it { should validate_presence_of(:recipient) }
end
